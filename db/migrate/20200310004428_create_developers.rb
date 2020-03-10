class CreateDevelopers < ActiveRecord::Migration[5.2]
  def change
    create_table :developers do |t|
      t.string :first_name
      t.string :last_name
      t.string :location
      t.text :bio
      t.text :slogan
      t.text :interests
      t.string :hireable
      t.text :websites, array: true, default: []
      t.text :social_links, array: true, default: []
      t.references :user, foreign_key: true
      t.string :github_profile_url

      t.timestamps
    end
  end
end
