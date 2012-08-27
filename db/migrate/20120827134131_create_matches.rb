class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :man_id
      t.integer :woman_id

      t.timestamps
    end
    
    add_index :matches, :man_id
    add_index :matches, :woman_id
    add_index :matches, [:man_id, :woman_id], unique: true
  end
end
