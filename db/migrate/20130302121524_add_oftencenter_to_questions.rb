class AddOftencenterToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :oftencenter, :string
  end
end
