import { Controller } from "@hotwired/stimulus";
import { FetchRequest } from '@rails/request.js';

export default class extends Controller {
  static get targets() { return ['button', 'badge'] }

  toggleJob(){
    const url = this.element.dataset.url
    const status = this.badgeTarget.innerHTML === 'Published' ? 'Unpublish' : 'Publish'
    this.request(url, status)
  }

  async toggleCart(e){
    const url = this.element.dataset.url

    if(confirm(`Are you sure you want to '${e.target.dataset.status}' ?`)){
      const request = new FetchRequest('post', url, { responseKind: "json" })
      const response = await request.perform()
      if (response.ok) {
        const data = await response.json
        if (data.cart_item) {
          e.target.classList.remove('btn-primary')
          e.target.classList.add('btn-danger')
          e.target.innerHTML = 'Remove from Cart'
          e.target.dataset.status = 'Remove from Cart'
        } else {
          e.target.classList.remove('btn-danger')
          e.target.classList.add('btn-primary')
          e.target.innerHTML = 'Add to Cart'
          e.target.dataset.status = 'Add to Cart'
        }
        if (data.cart_length) {
          document.querySelector('.checkout-button').removeAttribute('disabled')
        } else {
          document.querySelector('.checkout-button').setAttribute('disabled', true)
        }
      }
    }
  }

  async toggleUser(e){
    const status = e.target.checked ? 'active' : 'in_active'
    const updatingValue = status.split('_').length > 1 ? status.split('_').map(word => this.capitalizeWord(word)).join(' ') : this.capitalizeWord(status)
    const url = this.element.dataset.url + '?user[status]=' + status

    if(confirm(`Are you sure you want to '${updatingValue}' ?`)){
      const request = new FetchRequest('patch', url, { responseKind: "json" })
      const response = await request.perform()
      if (response.ok) {
        const data = await response.json
        const userStatus = data.user.status.split('_')
        this.badgeTarget.innerHTML = userStatus.length > 1 ? userStatus.map(word => this.capitalizeWord(word)).join(' ') : this.capitalizeWord(userStatus[0])
      }
    } else {
      e.target.checked = !e.target.checked
    }
  }

  capitalizeWord (word) {
    return word.charAt(0).toUpperCase() + word.slice(1)
  }

  async request(url, status) {
    if(confirm(`Are you sure you want to '${status}' ?`)){
      const request = new FetchRequest('patch', url, { responseKind: "json" })
      const response = await request.perform()
      if (response.ok) {
        const data = await response.json
        this.updateIcon(data.job)
      }
    }
  }

  updateIcon(job){
    if(job.published){
      this.badgeTarget.innerHTML = 'Published'
      this.badgeTarget.classList.remove('bg-danger')
      this.badgeTarget.classList.add('bg-success')
      this.buttonTarget.classList.remove('btn-success')
      this.buttonTarget.classList.add('btn-danger')
      this.buttonTarget.title = 'Unpublish'
    } else {
      this.badgeTarget.innerHTML = 'Not Published'
      this.badgeTarget.classList.remove('bg-success')
      this.badgeTarget.classList.add('bg-danger')
      this.buttonTarget.classList.remove('btn-danger')
      this.buttonTarget.classList.add('btn-success')
      this.buttonTarget.title = 'Publish'
    }
  }
}
