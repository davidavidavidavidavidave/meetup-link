import { Controller } from "@hotwired/stimulus"
import Typed from "typed.js"

// Connects to data-controller="typed-js"
export default class extends Controller {
  connect() {
    console.log("hello")
    new Typed(this.element, {
      strings: ["Get your meetup link", "find your midl..."],
      typeSpeed: 50,
      loop: true
    })
  }
}
