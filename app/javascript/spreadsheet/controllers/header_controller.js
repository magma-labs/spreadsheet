import { Controller } from 'stimulus'

export default class extends Controller {

  static targets = ["contextMenu"]

  connect() {
    //console.log(this.element, this.targets);
  }

  menu(event) {
    var dropdown = event.target.querySelector('sl-dropdown')
    console.log(dropdown);
    dropdown.appendChild(this.contextMenuTarget)
    this.contextMenuTarget.classList.remove('hidden')
    dropdown.show()
    event.preventDefault();

  }

  search() {
    window.dispatchEvent(new CustomEvent("toggle-search"))
  }
}
