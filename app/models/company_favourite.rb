class CompanyFavourite < ApplicationRecord
  belongs_to :company
  belongs_to :developer
end
