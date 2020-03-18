class Conversation < ApplicationRecord
  belongs_to :developer
  belongs_to :company
  has_many :messages, dependent: :destroy
  validates_uniqueness_of :developer, :scope => :company

  scope :between, -> (developer_id,company_id) do
    where(("conversations.developer_id=? AND conversations.company_id=? ) OR (conversations.developer_id=? AND conversations.company_id=?"), developer_id, company_id, company_id, developer_id)
  end
end
