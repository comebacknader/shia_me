class CreateMmsgs < ActiveRecord::Migration
  def change
    create_table :mmsgs do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.boolean :sender_seen
      t.boolean :receiver_seen
      t.boolean :sender_hide
      t.boolean :receiver_hide
      t.text :message

      t.timestamps
    end
  end
end
