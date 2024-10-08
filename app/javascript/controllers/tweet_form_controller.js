import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="tweet-form"
export default class extends Controller {
  static targets = ["textArea"];

  connect() {
    var textArea = this.textAreaTarget;
    const form = this.element;
    form.addEventListener("turbo:submit-end", function (event) {
      textArea.value = "";
    });
  }
}
