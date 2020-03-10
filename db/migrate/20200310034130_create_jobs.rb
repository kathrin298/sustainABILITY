class CreateJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs do |t|
      t.string :job_title
      t.text :job_description
      t.boolean :active
      t.references :company, foreign_key: true
      t.string :location
      t.boolean :remote
      t.date :start_date
      t.string :duration

      t.timestamps
    end
  end
end
