import { Controller } from "@hotwired/stimulus";
import { createConsumer } from "@rails/actioncable";

// Connects to data-controller="chatroom-subscription"
export default class extends Controller {
  static targets = ["messages"];
  static values = {
    chatroomId: Number,
    currentUserId: Number, // Define a value for current user ID
  };

  connect() {
    createConsumer().subscriptions.create(
      { channel: "ChatroomChannel", id: this.chatroomIdValue },
      {
        received: (data) => {
          this.insertMessage(data);
        },
      }
    );
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight);
  }

  resetForm(event) {
    event.target.reset();
  }

  insertMessage(data) {
    // Parse the received data as HTML
    const parser = new DOMParser();
    const message = parser.parseFromString(data, "text/html").body.firstChild;

    // Add a class to the message based on user ID
    if (message.classList.contains("msg")) {
      const userIdFromMessage = message.getAttribute("data-user-id");
      message.classList.add(
        userIdFromMessage == this.currentUser ? "left-msg" : "right-msg"
      );
    }

    // Append the modified message to the messages container
    this.messagesTarget.appendChild(message);

    // Scroll to the bottom of the container
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight);
  }

  get currentUser() {
    // You should implement a way to get the current user's ID here
    // This is just a placeholder, and you should replace it with your logic
    return parseInt(this.element.getAttribute("data-current-user-id"));
  }
}
