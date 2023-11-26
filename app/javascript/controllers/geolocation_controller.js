import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="geolocation"
export default class extends Controller {
  static targets = ["latInput", "lonInput"]

  connect() {
    console.log("Geolocation controller connected! Winnie the pooh");
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
