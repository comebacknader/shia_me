class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :user_id
      t.string :education
      t.string :job
      t.string :syed
      t.string :prayer
      t.string :hijab

      t.timestamps
    end
  end
end
