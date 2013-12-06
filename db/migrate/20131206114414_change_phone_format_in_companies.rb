class ChangePhoneFormatInCompanies < ActiveRecord::Migration
  def up
    change_column :companies, :phone, :integer
  end

  def down
    change_column :companies, :phone, :string
  end
end
