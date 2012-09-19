class CreateMsgs < ActiveRecord::Migration
  def change
    create_table :msgs do |t|
      t.integer :admin_id
      t.integer :user_id
      t.string :message

      t.timestamps
    end
  end
end
