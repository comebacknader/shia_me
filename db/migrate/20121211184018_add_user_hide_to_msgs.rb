class AddUserHideToMsgs < ActiveRecord::Migration
  def change
    add_column :msgs, :user_hide, :boolean
  end
end
