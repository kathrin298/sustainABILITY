class SetDefaultToActiveInJobs < ActiveRecord::Migration[5.2]
  def change
    change_column_default :jobs, :active, true
  end
end
