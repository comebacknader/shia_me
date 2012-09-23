class AddMeaningmuslimToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :islamtoyou, :string
  end
end
