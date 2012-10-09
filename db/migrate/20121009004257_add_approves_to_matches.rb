class AddApprovesToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :femapprove, :boolean
    add_column :matches, :infoapprove, :boolean
    add_column :matches, :picapprove, :boolean
  end
end
