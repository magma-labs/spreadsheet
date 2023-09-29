import { Controller } from 'stimulus'
import Mark from 'mark.js'
import hotkeys from 'hotkeys-js'

export default class extends Controller {
  static targets = ['input', 'dropdown', 'trigger', 'filter', 'highlight', 'results', 'next', 'previous', 'cancel']

  connect () {
    this.inputTarget.addEventListener('sl-input', this.input.bind(this))
    this.inputTarget.addEventListener('sl-clear', this.input.bind(this))
    this.dropdownTarget.addEventListener('sl-select', this.selectMode.bind(this))
    this.cancelTarget.addEventListener('click', this.cancel.bind(this))
    this.previousTarget.addEventListener('click', this.previous.bind(this))
    this.nextTarget.addEventListener('click', this.next.bind(this))
    this.marker = new Mark('.spreadsheet--sheet .searchable')
    hotkeys('ctrl+f, command+f', (event, handler) => {
      event.preventDefault()
      this.toggleSearch()
    })
  }

  input (event) {
    const value = event.target.value
    this.mark(value)

    if (this.filterTarget.checked) {
      this.element.closest('.spreadsheet--sheet').querySelectorAll('.spreadsheet--row').forEach((row) => {
        if (row.querySelector('mark') || value === '') {
          row.classList.remove('hidden')
        } else {
          row.classList.add('hidden')
        }
      })
      // remove the rows that don't match
    }
  }

  mark (value) {
    this.marker.unmark()
    this.marker.mark(value,
      {
        done: (num) => {
          this.currentMarkIndex = -1
          this.resultsTarget.innerHTML = `${num} found`
        }
      }
    )
  }

  currentMarks () {
    return this.element.closest('.spreadsheet--sheet').querySelectorAll('mark')
  }

  selectMode (event) {
    console.log('selectMode')
    const selectedItem = event.detail.item
    this.triggerTarget.textContent = selectedItem.textContent;
    [...this.dropdownTarget.querySelectorAll('sl-menu-item')].map(item => {
      item.checked = item === selectedItem
      return item.checked
    })
  }

  previous () {
    const marks = this.currentMarks()
    if (this.currentMarkIndex > 0) {
      this.currentMarkIndex -= 1
      marks.forEach((m) => m.classList.remove('current'))
      marks[this.currentMarkIndex].classList.add('current')
      this.resultsTarget.innerHTML = `${this.currentMarkIndex + 1} of ${marks.length} found`
    }
  }

  next () {
    const marks = this.currentMarks()
    if (this.currentMarkIndex < (marks.length - 1)) {
      this.currentMarkIndex += 1
      marks.forEach((m) => m.classList.remove('current'))
      marks[this.currentMarkIndex].classList.add('current')
      this.resultsTarget.innerHTML = `${this.currentMarkIndex + 1} of ${marks.length} found`
    }
  }

  cancel () {
    console.log('cancel')
    this.marker.unmark()
    this.toggleSearch()
  }

  toggleSearch () {
    this.element.classList.toggle('hidden')
    this.inputTarget.focus()
  }
}
