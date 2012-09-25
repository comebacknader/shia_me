class AddMessageToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :reason, :text
  end
end
