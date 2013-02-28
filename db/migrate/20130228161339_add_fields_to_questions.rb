class AddFieldsToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :edulevel, :string
    add_column :questions, :employed, :string
    add_column :questions, :employer, :string
    add_column :questions, :center, :string
    add_column :questions, :famdeen, :string
    add_column :questions, :visa, :string
    add_column :questions, :graduated, :string
    add_column :questions, :height, :string
    add_column :questions, :bodytype, :string
  end
end
