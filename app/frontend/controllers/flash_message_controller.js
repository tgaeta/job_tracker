import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  connect() {
    if (this.element.innerHTML.trim() !== '') {
      this.show();
    }
  }

  show() {
    this.element.classList.remove('hidden');
    setTimeout(() => {
      this.fadeOut();
    }, 2000);
  }

  fadeOut() {
    const flashMessage = this.element.querySelector('.flash-message');
    if (flashMessage) {
      flashMessage.classList.add('fade-out');
      setTimeout(() => {
        this.element.classList.add('hidden');
      }, 500);
    }
  }
}
