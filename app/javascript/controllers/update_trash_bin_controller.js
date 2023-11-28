import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="update-trash-bin"
export default class extends Controller {
  static targets = ["checkbox", "form"]

  connect() {
    console.log("update")
  }

  submit(event) {
    event.preventDefault();
    const url = this.formTarget.action
    const token = this.formTarget.querySelector('[name="authenticity_token"]').value;
    const method = this.formTarget.querySelector('[name="_method"]').value;
    const data = {
      trash_bin: { full: this.checkboxTarget.checked },
      authenticity_token: token,
      method: method,
    }

    fetch(url, {
      method: "PATCH",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(data)
    })
    .then(response => response.json()).then((data) => {
      console.log(data);
      this.checkboxTarget.checked = data.checked;
    })
  }
}
