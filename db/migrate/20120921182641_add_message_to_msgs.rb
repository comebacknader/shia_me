class AddMessageToMsgs < ActiveRecord::Migration
  def change
  	add_column :msgs, :message, :text
  end
end
