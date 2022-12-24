import { createApp } from 'vue'
import App from './upload-media.vue'

document.addEventListener('DOMContentLoaded', () => {
  const selector = '#js-upload-media'
  const element = document.querySelector(selector)
  if (document.querySelector(selector)) {
    const currentTwitterId = element.getAttribute('data-current-twitter-id')
    createApp(App, {
      currentTwitterId
    }).mount(selector)
  }
})
