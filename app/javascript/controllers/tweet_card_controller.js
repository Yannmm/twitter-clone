import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    const self = this.element;

    this.element.onclick = function (e) {
      let target = e.target;

      while (target !== self) {
        if (
          target.dataset.hasOwnProperty("ignoreClick") &&
          target.dataset.ignoreClick
        ) {
          return;
        }
        target = target.parentNode;
      }

      window.location.href = self.dataset.targetPath;
    };
  }
}
