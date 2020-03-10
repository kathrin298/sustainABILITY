class CreateDeveloperFavourites < ActiveRecord::Migration[5.2]
  def change
    create_table :developer_favourites do |t|
      t.references :company, foreign_key: true
      t.references :developer, foreign_key: true

      t.timestamps
    end
  end
end
