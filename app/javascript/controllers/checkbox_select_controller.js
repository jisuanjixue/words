import CheckboxSelectAll from 'stimulus-checkbox-select-all'

export default class extends CheckboxSelectAll {
  connect() {
    super.connect()
    console.log(  this.checked)
    // // Get all checked checkboxes

    // // Get all unchecked checkboxes
    // this.unchecked
  }

  deleteSelected(){
    const selectedCheckboxes = this.element.querySelectorAll('input[type="checkbox"]:checked');
    console.log(  this.checked, selectedCheckboxes)
  }

}