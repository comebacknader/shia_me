class AddUserIdToMquest < ActiveRecord::Migration
  def change
    add_column :mquests, :user_id, :integer
  end
end
