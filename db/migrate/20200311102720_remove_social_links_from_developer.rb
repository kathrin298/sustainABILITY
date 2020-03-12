class RemoveSocialLinksFromDeveloper < ActiveRecord::Migration[5.2]
  def change
    remove_column :developers, :social_links, :text
    remove_column :developers, :github_profile_url, :string
  end
end
