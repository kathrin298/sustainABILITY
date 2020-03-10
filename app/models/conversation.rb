class Conversation < ApplicationRecord
  belongs_to :developer
  belongs_to :company
  has_many :messages
end
