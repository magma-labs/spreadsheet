import { Controller } from 'stimulus'
import Sortable from 'sortablejs'

export default class extends Controller {
  connect () {
    // console.log("sorting!",this.element);
    window.sortable = new Sortable(this.element, {
      animation: 100,
      draggable: '.draggable',
      handle: '.draghandle',
      group: 'row-group'
    })
  }
}
