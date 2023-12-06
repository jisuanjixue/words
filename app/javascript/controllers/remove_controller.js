import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  del() {
    this.element.remove();
  }
}
