import { Controller } from "@hotwired/stimulus";
import mapboxgl from 'mapbox-gl';

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue;

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10",
      center: [139.7671, 35.6812],
      zoom: 13,
    });

    this.closestPlace = [this.markersValue[0].lng, this.markersValue[0].lat];

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
      geolocate.trigger();
      });

    geolocate.on('geolocate', (position) => {
      console.log('A geolocate event has occurred.');

      this.renderDirection(position, this.closestPlace);
    });
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

}
