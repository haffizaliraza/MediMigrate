import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.flash()
  }
  flash() {
    setTimeout(function() {
      $('.alert').fadeOut('fast');
    }, 3000);
  }
}
