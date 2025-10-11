import { Controller } from "@hotwired/stimulus"


export default class extends Controller {
static values = { target: String }


copy(event) {
const targetSelector = event.currentTarget.dataset.clipboardTarget
const input = document.querySelector(targetSelector)
if (!input) return


// Use modern clipboard API
if (navigator.clipboard && window.isSecureContext) {
navigator.clipboard.writeText(input.value).then(() => {
// show a small UI feedback (toast) — implement as you like
alert('Copied!')
})
} else {
input.select()
document.execCommand('copy')
alert('Copied!')
}
}
}