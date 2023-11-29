import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["latInput", "lonInput", "nameInput", "desInput"];
  currentUserLocation = null;
  map = null;
  userMarker = null;

  connect() {
    this.showLoading();
    this.initializeMap();
  }

  showLoading() {
    document.getElementById('loadingIndicator').style.display = 'block';
  }

  hideLoading() {
    document.getElementById('loadingIndicator').style.display = 'none';
  }

  initializeMap() {
    mapboxgl.accessToken = 'pk.eyJ1Ijoic2dna2R1a2UiLCJhIjoiY2xvNTVpamMxMDZ1bjJ2bng4YTJmeHgxZCJ9.UdCeZ5cXHGpJTyP5XeaPFw';
    this.map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v12?optimize=true',
      center: [139.7671, 35.6812],
      zoom: 18
    });

    const geocoder = new MapboxGeocoder({
      accessToken: mapboxgl.accessToken,
      mapboxgl: mapboxgl,
      marker: false,

      zoom: 18
    });

    //this.map.addControl(geocoder);
    // this.addUserMarker();

    this.map.on('load', () => {
      this.hideLoading();

    });


    this.map.on('click', e => {
      if (this.currentUserLocation) {
        const distance = this.calculateDistance(this.currentUserLocation, e.lngLat);
        if (distance <= 20) {
          this.setCoordinatesAndFetchAddress(e.lngLat);

          if (this.userMarker === null) {
            this.userMarker = new mapboxgl.Marker()
              .setLngLat(e.lngLat)
              .addTo(this.map);
          } else {
            this.userMarker.setLngLat(e.lngLat);
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
        this.map.setCenter(this.currentUserLocation);
        this.map.setZoom(18);
        this.addUserMarker();
        this.hideLoading();
      }, (error) => {
        console.error("Error getting the geolocation: ", error);
        this.hideLoading();
      }, { timeout: 10000 }); // Timeout for geolocation
    } else {
      console.log("Geolocation is not supported by this browser.");
    }
  }

  addUserMarker() {
    if (this.map.isStyleLoaded() && this.currentUserLocation && !this.userMarker) {
      this.userMarker = new mapboxgl.Marker()
        .setLngLat([this.currentUserLocation.lng, this.currentUserLocation.lat])
        .addTo(this.map);
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
          this.nameInputTarget.value = data.features[0].text;
          this.desInputTarget.value = data.features[0].place_name;
        }
      });
  }
}
