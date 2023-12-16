import { Controller } from "@hotwired/stimulus"
import CheckboxSelectAll from 'stimulus-checkbox-select-all'

export default class extends CheckboxSelectAll {
  connect() {
    super.connect()
    super.method()
  }
    handleCheckboxAllChange(event) {
        console.log("🚀 ~ file: checkbox_select_controller.js:19 ~ extends ~ handleCheckboxAllChange ~ event:", event)
        const isChecked = event.target.checked;
        this.checkboxTargets.forEach(checkbox => {
          checkbox.checked = isChecked;
        });
      }
}
