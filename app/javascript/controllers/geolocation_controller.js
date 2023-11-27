import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="geolocation"
export default class extends Controller {
  static targets = ["latInput", "lonInput", "nameInput", "desInput"];
  currentUserLocation = null; // Store the user's current location

  connect() {
    console.log("Geolocation controller connected!");
    this.initializeMap();
  }

  initializeMap() {
    mapboxgl.accessToken = 'pk.eyJ1Ijoic2dna2R1a2UiLCJhIjoiY2xvNTVpamMxMDZ1bjJ2bng4YTJmeHgxZCJ9.UdCeZ5cXHGpJTyP5XeaPFw';
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v11',
      zoom: 9
    });

    const geocoder = new MapboxGeocoder({
      accessToken: mapboxgl.accessToken,
      mapboxgl: mapboxgl,
      marker: false,
      zoom: 20
    });

    map.addControl(geocoder);

    let userMarker = null;

    map.on('click', e => {
      if (this.currentUserLocation) {
        const distance = this.calculateDistance(this.currentUserLocation, e.lngLat);
        if (distance <= 20) {
          this.setCoordinatesAndFetchAddress(e.lngLat);

          if (userMarker === null) {
            userMarker = new mapboxgl.Marker()
              .setLngLat(e.lngLat)
              .addTo(map);
          } else {
            userMarker.setLngLat(e.lngLat);
          }
        } else {
          alert("You can only select a location within 20 meters of your current position.");
        }
      }
    });

    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(position => {
        this.currentUserLocation = {
          lat: position.coords.latitude,
          lng: position.coords.longitude
        };
        map.setCenter(this.currentUserLocation);
        map.setZoom(15); // Zoom closer
        this.setCoordinatesAndFetchAddress(this.currentUserLocation);

        // Add a marker at the user's location
        userMarker = new mapboxgl.Marker()
          .setLngLat(this.currentUserLocation)
          .addTo(map);
      }, function(error) {
        console.error("Error getting the geolocation: ", error);
      });
    } else {
      console.log("Geolocation is not supported by this browser.");
    }
  }

  calculateDistance(loc1, loc2) {
    function toRad(x) {
      return x * Math.PI / 180;
    }

    const R = 6371; // Earth's mean radius in km
    const dLat = toRad(loc2.lat - loc1.lat);
    const dLon = toRad(loc2.lng - loc1.lng);

    const a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
              Math.cos(toRad(loc1.lat)) * Math.cos(toRad(loc2.lat)) *
              Math.sin(dLon / 2) * Math.sin(dLon / 2);
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    const d = R * c;

    return d * 1000; // Distance in meters
  }

  setCoordinatesAndFetchAddress(coordinates) {
    this.latInputTarget.value = coordinates.lat;
    this.lonInputTarget.value = coordinates.lng;
    this.fetchAddress(coordinates);
  }

  fetchAddress(coordinates) {
    const url = `https://api.mapbox.com/geocoding/v5/mapbox.places/${coordinates.lng},${coordinates.lat}.json?access_token=${mapboxgl.accessToken}`;

    fetch(url)
      .then(res => res.json())
      .then(data => {
        if (data.features && data.features.length > 0) {
          const fulladdress = data.features[0].place_name;
          const addressParts = fulladdress.split(", ");
          const namevalue = data.features[0].text; // First part of the address
          const desvalue = addressParts[1]; // Remaining parts

          this.nameInputTarget.value = namevalue;
          this.desInputTarget.value = desvalue;
        } else {
          this.nameInputTarget.value = "Please fill in";
          this.desInputTarget.value = "Please fill in";
        }
      })
      .catch(error => {
        console.error("Error fetching address: ", error);
        this.nameInputTarget.value = "Error";
        this.desInputTarget.value = "Error";
      });
  }

  getLocation() {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(
        position => {
          this.latInputTarget.value = position.coords.latitude;
          this.lonInputTarget.value = position.coords.longitude;
        },
        error => {
          console.error("Error getting position: ", error);
        }
      );
    } else {
      console.error("Geolocation is not supported by this browser.");
    }
  }
}
