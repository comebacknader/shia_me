class AddThreeColumnsToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :firsthobby, :string
    add_column :questions, :secondhobby, :string
    add_column :questions, :thirdhobby, :string
  end
end
