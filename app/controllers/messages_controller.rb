class MessagesController < ApplicationController
  before_action :find_conversation

  # def index
  #   @messages = @conversation.messages
  #   @message = @conversation.messages.new
  # end

  def new
    @message = @conversation.messages.new
  end

  def create
    @message = @conversation.messages.new(message_params)
    @message.user = current_user
    if @message.save
      respond_to do |format|
        format.html { redirect_to conversations_path }
        format.js  # <-- will render `app/views/messages/create.js.erb`
      end
    else
      respond_to do |format|
        format.html { render 'conversations/index' }
        format.js
      end
    end
  end

  private

  def find_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end

  def message_params
    params.require(:message).permit(:user, :content)
  end
end
