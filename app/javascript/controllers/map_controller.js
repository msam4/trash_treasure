import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'
// import MapboxDirections from '@mapbox/mapbox-gl-directions/dist/gl-directions';

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    console.log(this.markersValue)
    mapboxgl.accessToken = this.apiKeyValue;

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10",
      center: [0, 0],
      zoom: 1,
    });

    this.addMarkers();
    this.fitMapToMarkers();  // Call the function to fit map to markers
    this.renderDirection();
  }

  addMarkers() {
    this.markersValue.forEach(marker => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window_html);
      console.log(marker)
      const customMarker = document.createElement("div");
      customMarker.innerHTML = marker.marker_html;

      new mapboxgl.Marker(customMarker)
        .setLngLat([marker.lng, marker.lat])
        .setPopup(popup)
        .addTo(this.map);
    });
  }

  fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds();
    this.markersValue.forEach(marker => bounds.extend([marker.lng, marker.lat]));
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
  }

  renderDirection() {
    let direction

    if (direction) {
      this.map.removeControl(direction)
    }
    direction = new MapboxDirections({
        accessToken: mapboxgl.accessToken,
        routePadding: 50,
        controls: {
          inputs: false,
          instructions: false
        }
      })
    this.map.addControl(
      direction,
      'top-left'
    );

    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition((position) => {
        console.log([position.coords.longitude, position.coords.latitude])
        direction.setOrigin([position.coords.longitude, position.coords.latitude])
        direction.setDestination([139.7043604, 35.6689704])
      });
    }
  }

}
