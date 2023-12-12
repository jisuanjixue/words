import { Controller } from "@hotwired/stimulus"
import { Modal } from 'flowbite';

export default class extends Controller {
    connect() {
        const targetEl = document.getElementById('modalEl');

        // options with default values
        const options = {
            placement: 'bottom-right',
            backdrop: 'dynamic',
            backdropClasses: 'bg-gray-900 bg-opacity-50 dark:bg-opacity-80 fixed inset-0 z-40',
            closable: true
        };
        this.modal = new Modal(targetEl, options);
    }

    open() {
        console.log("swwww")
        if (!this.modal.isOpened) {
            this.modal.show()
        }
    }

    close(event) {
        if (event.detail.success) {
            this.modal.hide()
        }
    }
    closeIcon() {
        this.modal.hide()
    }
}