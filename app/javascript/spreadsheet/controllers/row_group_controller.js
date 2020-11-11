import { Controller } from 'stimulus'
import Sortable from 'sortablejs'

export default class extends Controller {

  static targets = ['collapseContainer']

  connect() {
  }

  highlight() {
    document.querySelectorAll(".spreadsheet--row-group").forEach(node => node.classList.remove("highlight"))
    this.element.classList.add("highlight")
  }

  collapse() {
    this.element.classList.toggle('collapsed');
    this.collapseContainerTarget.classList.toggle('hidden');
  }
}
