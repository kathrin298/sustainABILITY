class AddSocialsToDeveloper < ActiveRecord::Migration[5.2]
  def change
    add_column :developers, :facebook, :string
    add_column :developers, :github, :string
    add_column :developers, :twitter, :string
    add_column :developers, :linkedin, :string
  end
end
