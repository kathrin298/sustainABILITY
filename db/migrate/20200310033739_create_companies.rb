class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :location
      t.references :user, foreign_key: true
      t.text :mission
      t.integer :employees
      t.string :industry
      t.text :bio
      t.string :website
      t.string :video_url

      t.timestamps
    end
  end
end
