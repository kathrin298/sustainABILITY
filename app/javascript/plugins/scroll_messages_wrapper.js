const bindConversations = () => {
  const conversations = document.querySelectorAll('.inbox-container .nav-link')
  conversations.forEach((conversation) => {
    conversation.addEventListener('click', (event) => {
      setTimeout(function() { scrollMessagesWrapper() }, 200)
    });
  })
}


const scrollMessagesWrapper = () => {
  const messages = document.querySelector('.show.active');
  if (messages) {
    messages.scrollTop = messages.scrollHeight;
  }
};

export { bindConversations, scrollMessagesWrapper };
