import Cleave from 'cleave.js';
import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ["display", "input"]

  connect() {
    if(this.hasInputTarget && this.element.classList.contains("money")) {
      new Cleave(this.inputTarget, {
        numeral: true,
        numeralThousandsGroupStyle: 'thousand'
      })
    }

    // this.element.addEventListener("blur", this.blur.bind(this))
  }

  get tooltip() {
    return this.displayTarget.querySelector('sl-tooltip');
  }

  focus() {
    // if(this.element.dataset.error) {
    //   this.tooltip.open = true
    // }
    // document.dispatchEvent(new Event("spreadsheet:cell-focus"))
  }

  blur() {
    // this.tooltip.open = false
  }
  // -- keyboard events

  navigate(event) {
    var isHidden = !this.hasInputTarget || this.inputTarget.classList.contains("hidden")
    switch(event.keyCode) {
      case 13: // Enter
        this.toggleInput(isHidden);
        return;
      case 27: // Esc
        if(this.hasInputTarget) {
          this.hideInput()
          this.restorePreviousValue()
        }
        return;
      case 37:
        isHidden && this.left();
        return;
      case 38:
        isHidden && this.up();
        return;
      case 39:
        isHidden && this.right();
        return;
      case 40:
        isHidden && this.down();
    }
  }

  // -- input events

  change() {
    console.log("change", event);
    this.markModified();
    const isMoney = this.element.classList.contains("money") ? '$' : ''
    const displayValue = isMoney ? parseFloat(this.inputTarget.value.replace(/,/g, '')).toLocaleString('en-US', { style: 'currency', currency: 'USD'}) : this.inputTarget.value
    this.displayTarget.querySelector(".inline-block").innerHTML = displayValue
  }

  markModified() {
    if(this.inputTarget.value != this.element.dataset.value) {
      this.element.classList.add("modified")
    }
    else {
      this.element.classList.remove("modified")
    }
  }

  restorePreviousValue() {
    this.inputTarget.value = this.inputTarget.dataset.previousValue
    this.change()
  }

  // -- visibility of input --

  toggleInput(isHidden) {
    if(this.hasInputTarget) {
      isHidden ? this.showInput() : this.hideInput()
    }
  }

  showInput(event) {
    // guard
    if(!this.hasInputTarget) {
      this.animateCSS(this.element, "headShake")
      return;
    }

    if(this.inputTarget.hasAttribute("disabled") || this.inputTarget.hasAttribute("readonly")) {
      this.animateCSS(this.element, "headShake") // todo: animate__faster probably more appropriate
    }
    else {
      this.displayTarget.classList.add("hidden")
      this.inputTarget.dataset.previousValue = this.inputTarget.value
      this.inputTarget.classList.remove("hidden")
      this.inputTarget.focus()
      this.inputTarget.select()
    }
  }

  hideInput(event) {
    this.displayTarget.classList.remove("hidden")
    this.inputTarget.classList.add("hidden")
    this.element.focus()
  }

  // -- focus navigation functions --

  left() {
    this.element.previousElementSibling?.focus();
  }

  right() {
    this.element.nextElementSibling?.focus();
  }

  down() {
    var element = this.getCellByPosition(1)?.closest(".spreadsheet--cell")
    element?.focus()
    this.simulateMouseEvent(element, 'mousedown')
   }

  up() {
    var element = this.getCellByPosition(-1)
    element?.closest(".spreadsheet--cell")?.focus()
    this.simulateMouseEvent(element, 'mousedown')
  }

  simulateMouseEvent(element, eventType) {
    var event = new MouseEvent(eventType, {
      bubbles: true,
      cancelable: true
    })
    element?.dispatchEvent(event)
  }

  getCellByPosition(upDown) {
    var rect = this.element.getBoundingClientRect();
    var height = rect.bottom - rect.top;
    var middle = rect.top + height / 2;
    var center = (rect.right - rect.left) / 2;
    var x = this.element.dataset.lastX || rect.left + center;
    var target = document.elementFromPoint(x, middle + height * upDown)?.closest(".spreadsheet--cell")
    target && (target.dataset.lastX = x);
    return target;
  }

  // animate.css

  animateCSS(node, animation, prefix = 'animate__') {
    // We create a Promise and return it
    new Promise((resolve, reject) => {
      const animationName = `${prefix}${animation}`;

      node.classList.add(`${prefix}animated`, animationName);

      // When the animation ends, we clean the classes and resolve the Promise
      function handleAnimationEnd() {
        node.classList.remove(`${prefix}animated`, animationName);
        resolve('Animation ended');
      }

      node.addEventListener('animationend', handleAnimationEnd, {once: true});
    });
  }
}
