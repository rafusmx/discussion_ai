import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="message-form"
export default class extends Controller {
  connect() {
  }

  resetInput() {
    this.element.reset()
  }
}
