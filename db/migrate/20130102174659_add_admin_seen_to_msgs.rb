class AddAdminSeenToMsgs < ActiveRecord::Migration
  def change
    add_column :msgs, :admin_seen, :boolean
  end
end
