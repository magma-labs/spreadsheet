/* global Image */
import { Controller } from 'stimulus'

import './sheet.scss'

export default class extends Controller {
  connect () {
    this.ghost = new Image()
    this.ghost.src = 'data:image/gif;base64,R0lGODlhAQABAIAAAAUEBAAAACwAAAAAAQABAAACAkQBADs='

    document.addEventListener('spreadsheet:cell-focus', this.clearSum.bind(this))

    window.addEventListener('cable-ready:after-morph', function (event) {
      const tags = ['sl-dropdown', 'sl-menu', 'sl-menu-item', 'sl-icon']
      tags.forEach(tag => {
        document.querySelectorAll(tag).forEach(el => {
          el.classList.add('hydrated')
        })
      })
    })
  }

  startSum (event) {
    const cell = event.target.closest('.spreadsheet--cell')
    if (cell && cell.dataset.type && cell.dataset.nestingLevel) {
      cell.blur()
      this.sumCellSet = new Set([cell])
      this.currentDraggableCellType = cell.dataset.type
      this.currentDraggableNestingLevel = cell.dataset.nestingLevel
      event.dataTransfer.setDragImage(this.ghost, 0, 0)
      cell.classList.add('highlight-sum')
      document.querySelectorAll(`.spreadsheet--row[data-nesting-level]:not([data-nesting-level='${this.currentDraggableNestingLevel}'])`).forEach(node => node.classList.add('transition-opacity', 'opacity-25', 'duration-200'))
    }
  }

  calculateSum (event) {
    if (typeof (event.target.closest) !== 'function') return

    const cell = event.target?.closest('.spreadsheet--cell')
    if (cell && cell.dataset.type === this.currentDraggableCellType && cell.dataset.nestingLevel === this.currentDraggableNestingLevel) {
      // remove current highlight in rows and highlight cell
      document.querySelectorAll('.spreadsheet--row').forEach(node => node.classList.remove('highlight'))
      cell.classList.add('highlight-sum')

      // calculate updated sum
      let sum = 0
      this.sumCellSet.add(cell)
      this.sumCellSet.forEach(node => {
        const nodeValue = node.querySelector('.spreadsheet--cell-display .inline-block')?.innerHTML
        sum += parseInt(nodeValue?.replace(/[^\d.-]/g, '')) || 0
      })

      // display to user
      this.notifyDragSum(sum)
    }
  }

  clearSum (event) {
    this.dragSumAlert?.hide()
    this.dragSumAlert = null
    document.querySelectorAll('.spreadsheet--cell').forEach(node => node.classList.remove('highlight-sum'))
    document.querySelectorAll('.spreadsheet--row').forEach(node => node.classList.remove('opacity-25'))
  }

  escapeHtml (html) {
    const div = document.createElement('div')
    div.textContent = html
    return div.innerHTML
  }

  notifyDragSum (value) {
    if (this.dragSumAlert) {
      const root = this.dragSumAlert.shadowRoot.querySelector('.alert__message')
      root && (root.innerHTML = `Sum: ${value}`)
    } else {
      const opts = {
        type: 'warning',
        closable: true,
        innerHTML: `
          <sl-icon name="plus" slot="icon"></sl-icon>
          ${this.escapeHtml(`Sum: ${value}`)}
        `
      }

      this.dragSumAlert = Object.assign(document.createElement('sl-alert'), opts)
      this.dragSumAlert.addEventListener('sl-hide', this.clearSum)
      document.body.append(this.dragSumAlert)

      this.dragSumAlert.toast()
    }
  }
}
