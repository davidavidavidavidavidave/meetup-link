import { Controller } from "@hotwired/stimulus"
// import { Controller } from "stimulus";

export default class extends Controller {
  connect() {
    // Get the passcode and chatroom path from the data attributes
    const passcode = this.element.getAttribute("data-passcode");
    const chatroomPath = this.element.getAttribute("data-chatroom-path");

    // Listen for a click on the element
    this.element.addEventListener("click", (event) => {
      event.preventDefault();

      // Create the passcode message
      const passcodeMessage = `This is the passcode for the meetup: ${passcode}`;

      // Copy the passcode message to the clipboard
      const textArea = document.createElement("textarea");
      textArea.value = passcodeMessage;
      document.body.appendChild(textArea);
      textArea.select();
      document.execCommand("copy");
      document.body.removeChild(textArea);

      // Redirect to the chat page
      window.location.href = chatroomPath;

      // Paste the passcode message into a designated input field (replace "input-field-id" with the actual ID)
      const inputField = document.getElementById("input-field-id");
      inputField.value = passcodeMessage;
    });
  }
}
