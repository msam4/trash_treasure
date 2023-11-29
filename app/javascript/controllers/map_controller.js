
import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'
// import MapboxDirections from '@mapbox/mapbox-gl-directions/dist/gl-directions';

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    // console.log(this.markersValue)
    mapboxgl.accessToken = this.apiKeyValue;

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
  }

  addMarkers() {
    console.log("Add markers")
    this.markersValue.forEach(marker => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window_html);

      const customMarker = document.createElement("div");
      customMarker.innerHTML = marker.marker_html;

      new mapboxgl.Marker(customMarker)
        .setLngLat([marker.lng, marker.lat])
        .setPopup(popup)
        .addTo(this.map);
    });
  }

  fitMapToMarkers() {
    console.log("Fit markers")
    const bounds = new mapboxgl.LngLatBounds();
    bounds.extend([this.position.coords.longitude, this.position.coords.latitude]);
    console.log([this.position.coords.longitude, this.position.coords.latitude]);
    // Code below display the closest marker to the user's position
    bounds.extend(this.closestPlace);
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 200 });
  }

  trackUserLocationStart() {
    console.log("Track user")
    // Initialize the GeolocateControl.
    const geolocate = new mapboxgl.GeolocateControl({
      positionOptions: {
          enableHighAccuracy: true
      },
      trackUserLocation: true
    });
    // Add the control to the map.
    this.map.addControl(geolocate);
    // Set an event listener that fires
    this.map.on('load', () => {
      geolocate.trigger();
       // Initialize directions
       this.addDirectionControl();
      });
    // when a trackuserlocationstart event occurs. This code below is the origin in renderDirection
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
      console.log(closestMarker);

    return closestMarker;

  }

  renderDirection(origin, destination) {
    // console.log(destination)

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
