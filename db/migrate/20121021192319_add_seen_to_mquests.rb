class AddSeenToMquests < ActiveRecord::Migration
  def change
    add_column :msgs, :seen, :boolean
  end
end
