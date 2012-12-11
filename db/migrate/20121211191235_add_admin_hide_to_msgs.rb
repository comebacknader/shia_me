class AddAdminHideToMsgs < ActiveRecord::Migration
  def change
    add_column :msgs, :admin_hide, :boolean
  end
end
