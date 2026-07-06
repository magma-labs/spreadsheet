import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['checkbox']

  connect () {
    // console.log(this.element, this.targets);
  }

  isSelectionMode () {
    // Stimulus 3 removed the `this.data` API; read the same
    // `data-<identifier>-mode` attribute directly to preserve behavior.
    return this.element.getAttribute(`data-${this.identifier}-mode`)
  }

  highlight () {
    if (!this.isSelectionMode()) {
      this.cleanHighlight()
      this.element.classList.add('highlight')
    }
  }

  cleanHighlight () {
    document.querySelectorAll('.spreadsheet--row').forEach(node => node.classList.remove('highlight'))
    document.querySelectorAll('.spreadsheet--cell').forEach(node => node.classList.remove('dragsum'))
  }

  toggleSelectionMode () {
    this.cleanHighlight()
    document.querySelectorAll('.draghandle').forEach(node => node.classList.toggle('hidden'))
    document.querySelectorAll('.row-checkbox').forEach(node => node.classList.toggle('hidden'))

    if (this.isSelectionMode()) {
      document.querySelectorAll('.spreadsheet--row').forEach(node => {
        node.dataset['spreadsheet-RowMode'] = ''
        node.querySelector('.row-checkbox').removeAttribute('checked')
      })
    } else {
      document.querySelectorAll('.spreadsheet--row').forEach(node => {
        node.dataset['spreadsheet-RowMode'] = true
      })
      this.checkboxTarget.setAttribute('checked', true)
      this.element.classList.add('highlight')
    }
  }

  selectRow (event) {
    event.preventDefault()
    if (this.checkboxTarget.hasAttribute('checked')) {
      this.element.classList.remove('highlight')
      this.checkboxTarget.removeAttribute('checked', true)
    } else {
      this.checkboxTarget.setAttribute('checked', true)
      this.element.classList.add('highlight')
    }
  }
}
