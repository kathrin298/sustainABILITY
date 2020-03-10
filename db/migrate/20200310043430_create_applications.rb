class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.references :developer, foreign_key: true
      t.references :job, foreign_key: true
      t.string :status, default: 'pending'

      t.timestamps
    end
  end
end
