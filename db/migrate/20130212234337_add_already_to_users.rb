class AddAlreadyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :already, :text
  end
end
