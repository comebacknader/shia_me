class AddEthnicityToAdmin < ActiveRecord::Migration
  def change
    add_column :admins, :ethnicity, :string
  end
end
