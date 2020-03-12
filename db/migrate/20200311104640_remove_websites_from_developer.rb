class RemoveWebsitesFromDeveloper < ActiveRecord::Migration[5.2]
  def change
    remove_column :developers, :websites, :text
  end
end
