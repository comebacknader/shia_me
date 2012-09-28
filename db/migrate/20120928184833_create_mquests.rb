class CreateMquests < ActiveRecord::Migration
  def change
    create_table :mquests do |t|
      t.string :agerange
      t.string :edulevel
      t.string :ethnic
      t.string :needhijabi
      t.text :anypref

      t.timestamps
    end
  end
end
