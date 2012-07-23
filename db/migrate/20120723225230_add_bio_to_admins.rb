class AddBioToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :bio, :text
    add_column :admins, :location, :string
  end
end
