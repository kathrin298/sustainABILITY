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
      redirect_to conversations_path
    else
      render 'new'
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