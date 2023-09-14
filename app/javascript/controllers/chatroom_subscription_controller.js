import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="chatroom-subscription"
export default class extends Controller {
  static targets = ["messages"]
  static values = {
    chatroomId: Number
  }
  connect() {
    console.log(`connecting to ActionCable channel with id ${this.chatroomIdValue}`)

    createConsumer().subscriptions.create(
      { channel: "ChatroomChannel", id: this.chatroomIdValue },
      { received: data => {this.#insertMessage(data)} }
      )
  }

  resetForm(event) {
    event.target.reset()
  }

  // private
  #insertMessage(data) {
    this.messagesTarget.insertAdjacentHTML("beforeend", data)
  this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
  }
}
