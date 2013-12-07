class AddTypeToPassports < ActiveRecord::Migration
  def up
    add_column :passports, :type, :string
  end

  def down
    remove_column :passports, :type
  end
end
