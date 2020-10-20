import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ 'notify' ];

  connect() {
    this.refresh()
    setInterval(this.refresh, 5000);
  }

  updateNotification = (data) => {
    const unread = data.messages.length
    if (unread !== 0) {
      this.notifyTarget.style.visibility = 'visible'
      this.notifyTarget.innerText = unread

    } else {
      this.notifyTarget.style.visibility = 'hidden'
    }
  }



refresh = () => {
    fetch('/messages', { headers: { accept: 'application/json' } })
      .then(response => response.json())
      .then((data) => {
        this.updateNotification(data)
      });
  }
}


