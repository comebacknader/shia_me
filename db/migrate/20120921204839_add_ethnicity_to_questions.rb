class AddEthnicityToQuestions < ActiveRecord::Migration
  def change
  	add_column :questions, :ethnicity, :string
  end
end
