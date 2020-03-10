class ChangeJobstartToString < ActiveRecord::Migration[5.2]
  def change
    change_column :jobs, :start_date, :string
  end
end
