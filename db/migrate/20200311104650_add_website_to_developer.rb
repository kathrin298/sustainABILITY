class AddWebsiteToDeveloper < ActiveRecord::Migration[5.2]
  def change
    add_column :developers, :website, :string
  end
end
