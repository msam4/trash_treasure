import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="filter"
export default class extends Controller {
  static targets = ["latInput", "lonInput"];
  connect() {
    console.log("Geolocation controller connected!");
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(position => {
        this.latInputTarget.value = position.coords.latitude;
        this.lonInputTarget.value = position.coords.longitude;
      });
    }
  }
}
