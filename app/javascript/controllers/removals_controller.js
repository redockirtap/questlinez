import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  remove() {
    console.log('test')
    setTimeout((() => this.element.remove()), 1500)
  }
}