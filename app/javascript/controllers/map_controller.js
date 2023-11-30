import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'
// import MapboxDirections from '@mapbox/mapbox-gl-directions/dist/gl-directions';

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue;

    this.showLoading()

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10",
      center: [139.7671, 35.6812],
      zoom: 13,
    });

    // this.closestPlace = [this.markersValue[0].lng, this.markersValue[0].lat];

    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition((position) => {
        this.position = position;
        this.trackUserLocationStart();
        this.addMarkers();
        this.addDirectionControl();
      });
    }

    this.map.getCanvas().addEventListener('click', () => {
      document.querySelectorAll(".custom-popup").forEach(popup => popup.remove());
    });
  }

  showLoading() {
    document.getElementById('loadingIndicator').style.display = 'block';
  }

  hideLoading() {
    document.getElementById('loadingIndicator').style.display = 'none';
  }

  addMarkers() {
    console.log("Add markers")
    this.markersValue.forEach(marker => {
      const customMarker = document.createElement("div");
      customMarker.innerHTML = marker.marker_html;

      const coordinates = [marker.lng, marker.lat];

      const popupContainer = document.createElement("div");
      popupContainer.className = "custom-popup";
      popupContainer.innerHTML = `
        <div style="
          position: fixed;
          bottom: 0;
          text-align: center;
          width: 100%;
          background-color: white;
          padding: 10px;
        ">
          <h1 style="font-size: 24px;">${marker.info_window_html}</h1>
        </div>
      `;

      customMarker.addEventListener("click", (event) => {
        document.querySelectorAll(".custom-popup").forEach(popup => popup.remove());

        this.map.getContainer().appendChild(popupContainer);

        event.stopPropagation();

        this.renderDirection(this.position, coordinates);
      });

      // Set a timeout to display the custom alert after 10 seconds (adjust the time as needed)
      setTimeout(() => {
        Swal.fire({
          title: 'You have arrived!',
          text: 'Feel free to throw away your trash now 🥳',
          icon: 'success',
          confirmButtonText: 'OK',
          customClass: {
            confirmButton: 'btn btn-flat-primary m-3 p-4 text-center btn-md', // Apply Bootstrap classes directly to the button
          },

          didOpen: () => {
            const confirmButton = Swal.getConfirmButton();
            confirmButton.style.backgroundColor = '#618264';
            confirmButton.style.color = '#fff';


            confirmButton.addEventListener('click', () => {
              Swal.fire({
                title: 'Toss created!',
                icon: 'success',
                confirmButtonText: 'OK',
                customClass: {
                  confirmButton: 'btn btn-flat-primary m-3 p-4 text-center btn-md', // Apply Bootstrap classes directly to the button
                },
                didOpen: () => {
                  const confirmButton = Swal.getConfirmButton();
                  confirmButton.style.backgroundColor = '#618264';
                  confirmButton.style.color = '#fff';
                },
              });
            });
          },
        });
      }, 10000);

      new mapboxgl.Marker(customMarker)
        .setLngLat(coordinates)
        .addTo(this.map);
    });
  }

  fitMapToMarkers() {
    console.log("Fit markers")
    const bounds = new mapboxgl.LngLatBounds();
    bounds.extend([this.position.coords.longitude, this.position.coords.latitude]);
    console.log([this.position.coords.longitude, this.position.coords.latitude]);

    bounds.extend(this.closestPlace);
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 200 });
  }

  trackUserLocationStart() {
    console.log("Track user")

    const geolocate = new mapboxgl.GeolocateControl({
      positionOptions: {
          enableHighAccuracy: true
      },
      trackUserLocation: true
    });

    this.map.addControl(geolocate);
    this.map.on('load', () => {
      this.hideLoading();
      geolocate.trigger();
       // Initialize directions
       this.addDirectionControl();

      });

    geolocate.on('geolocate', (position) => {
      console.log('A geolocate event has occurred.');
      // Find closest marker
      this.closestPlace = this.findClosestMarker(position);
      // This code below is the destination in renderDirection
      this.renderDirection(position, this.findClosestMarker(position));
    });
  }

  // Find closest marker to user's location
  findClosestMarker(userPosition) {

    let minDistance = Infinity;
    let closestMarker = null;

    this.markersValue.forEach(marker => {

      const distance = this.calculateDistance( {lat: userPosition.coords.latitude, lng: userPosition.coords.longitude},
        {lat: marker.lat, lng: marker.lng}
      );

      if(distance < minDistance){
        minDistance = distance;
        closestMarker = [marker.lng, marker.lat];
      }
    });

    if(minDistance > 10000 ){
      alert("Please note: Trash bins are not within 10km radius of you."); // Display an alert or handle appropriately
    this.hideLoading();
    closestMarker = [marker.lng, marker.lat];
    ;
    }
      console.log(closestMarker);
      return closestMarker;

  }

  renderDirection(origin, destination) {

    this.direction.setOrigin([origin.coords.longitude, origin.coords.latitude]);
    this.direction.setDestination(destination);
  }

  addDirectionControl() {
    this.direction = new MapboxDirections({
        accessToken: mapboxgl.accessToken,
        routePadding: 50,
        profile: "mapbox/walking",
        interactive: false,
        controls: {
          inputs: false,
          instructions: false,
        }
      })
    this.map.addControl(
      this.direction,
      'top-left'
    );
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

}
