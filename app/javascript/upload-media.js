import { createApp } from 'vue'
import App from './upload-media.vue'

document.addEventListener('DOMContentLoaded', () => {
  const selector = '#js-upload-media'
  if (document.querySelector(selector)) {
    createApp(App).mount(selector)
  }
})
