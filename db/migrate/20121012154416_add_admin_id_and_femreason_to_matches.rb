class AddAdminIdAndFemreasonToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :admin_id, :integer
    add_column :matches, :femreason, :string
  end
end
