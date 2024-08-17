// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";
import * as bootstrap from "bootstrap";

document.addEventListener("turbo:before-fetch-request", function (event) {
  const modal = document.querySelector(".modal.show");
  if (modal) {
    modal.classList.remove("show");
  }
});