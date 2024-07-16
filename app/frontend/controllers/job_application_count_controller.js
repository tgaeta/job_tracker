import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['count'];

  update(event) {
    this.countTarget.textContent = event.detail.count;
  }
}
