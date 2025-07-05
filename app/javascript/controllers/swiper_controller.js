import { Controller } from "@hotwired/stimulus"
import swiper from "swiper"

// Connects to data-controller="swiper"
export default class extends Controller {
  static targets = ["next", "prev"]

  connect() {
    this.swiper = new Swiper(this.element, {
      slidesPerView: 1, // Show 1 group of 5 cards
      spaceBetween: 30,
      loop: false,
      navigation: {
        nextEl: this.nextTarget,
        prevEl: this.prevTarget
      },
    })
  }
}
