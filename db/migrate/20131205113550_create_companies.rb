class CreateCompanies < ActiveRecord::Migration
  def up
    create_table :companies do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :country
      t.string :email
      t.string :phone
      t.integer :owner_id
      t.integer :director_id
      t.timestamps
    end
  end

  def down
    drop_table :companies
  end
end
