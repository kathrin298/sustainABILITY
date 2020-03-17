class ConversationsController < ApplicationController
  def index
    @users = User.all
    @conversations = Conversation.all
  end

  def create
    if Conversation.between(params[:developer_id], params[:company_id]).present?
      @conversation = Conversation.between(params[:developer_id], params[:company_id]).first
    else
      @conversation = Conversation.create(conversation_params)
    end
    redirect_to new_conversation_message_path(@conversation)
  end

  private

  def conversation_params
    params.permit(:company_id, :developer_id)
  end

end
