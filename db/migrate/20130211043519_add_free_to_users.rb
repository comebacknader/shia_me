class AddFreeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :free, :boolean
  end
end
