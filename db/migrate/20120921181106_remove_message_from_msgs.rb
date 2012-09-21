class RemoveMessageFromMsgs < ActiveRecord::Migration
  def up
  	remove_column :msgs, :message
  end

  def down
  	add_column :msgs, :message, :string
  end
end
