class RemoveDirectorIdAndOwnerIdFromCompanies < ActiveRecord::Migration
  def up
    remove_column :companies, :owner_id
    remove_column :companies, :director_id
  end

  def down
    add_column :companies, :owner_id
    add_column :companies, :director_id
  end
end
