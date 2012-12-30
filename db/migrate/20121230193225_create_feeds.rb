class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :title
      t.text :post
      t.integer :feedable_id
      t.string :feedable_type
      t.integer :admin_id

      t.timestamps
    end
  end
end
