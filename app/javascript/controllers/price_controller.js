import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="price"
export default class extends Controller {
  static targets = ["total"]

  update() {
    const startInput = document.querySelector('input[name="booking[start_date]"]').value;
    const endInput = document.querySelector('input[name="booking[end_date]"]').value;
    const pricePerNight = parseFloat(document.querySelector("#price-per-night").dataset.pricePerNight);

    if (startInput && endInput) {
      const startDate = new Date(startInput)
      const endDate = new Date(endInput)
      const duration = (endDate - startDate) / (1000 * 60 * 60 * 24);

      if (duration > 0) {
        const total = duration * pricePerNight
        this.totalTarget.innerText = `€${total}`
      } else {
        this.totalTarget.innerText = "€0"
      }
    }
  }
}
