class RenameTypeToKindInPassports < ActiveRecord::Migration
  def up
    add_column :passports, :kind, :string
    remove_column :passports, :type
  end

  def down
    add_column :passports, :type, :string
    remove_column :passports, :kind
  end
end
