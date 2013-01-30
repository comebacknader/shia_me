class AddRaceToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :race, :string
  end
end
