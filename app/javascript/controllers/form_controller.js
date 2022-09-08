import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["message"]
  
  reset() {
    const value = this.messageTarget.value;
    const element = document.getElementById("messages")
    const html = `<div class="message message--sent"><p>${value}</p></div>`

    element.insertAdjacentHTML('beforeend', html)
    this.element.reset()
  }
}
