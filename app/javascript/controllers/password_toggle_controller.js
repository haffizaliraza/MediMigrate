import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static get targets() { return ["password", "eyeIcon", "slashEyeIcon"]; }

  toggle(e) {
    e.preventDefault();

    this.eyeIconTarget.classList.toggle("d-none");
    this.slashEyeIconTarget.classList.toggle("d-none");

    this.passwordTarget.type = (this.passwordTarget.type == "password") ? "text" : "password";
  }
}
