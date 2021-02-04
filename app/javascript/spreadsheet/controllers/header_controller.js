/* global CustomEvent */
import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['contextMenu']

  connect () {
    // console.log(this.element, this.targets);
  }

  menu (event) {
    const dropdown = event.target.querySelector('sl-dropdown')
    console.log(dropdown)
    dropdown.appendChild(this.contextMenuTarget)
    this.contextMenuTarget.classList.remove('hidden')
    dropdown.show()
    event.preventDefault()
  }

  search () {
    window.dispatchEvent(new CustomEvent('toggle-search'))
  }

  toggleColumn (event) {
    const menu = event.target.closest('sl-menu-item')
    const selector = `.spreadsheet--cell.${menu.dataset.id}`
    const cells = document.querySelectorAll(selector)
    if (menu.checked) { // hide
      cells.forEach(c => c.classList.add('hidden'))
      menu.checked = false
    } else {
      cells.forEach(c => c.classList.remove('hidden'))
      menu.checked = true
    }
  }
}
