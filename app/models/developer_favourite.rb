class DeveloperFavourite < ApplicationRecord
  belongs_to :company
  belongs_to :developer
end
