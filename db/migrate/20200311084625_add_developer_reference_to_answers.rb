class AddDeveloperReferenceToAnswers < ActiveRecord::Migration[5.2]
  def change
    add_reference :answers, :developer, foreign_key: true
  end
end
