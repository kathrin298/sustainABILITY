class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  validates_presence_of :content, :conversation, :user

  # def message_time
  #   created_at.strftime(“%m/%d/%y at %l:%M %p”)
  # end
end
