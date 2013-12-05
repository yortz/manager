class CreatePassports < ActiveRecord::Migration
  def up
    create_table :passports do |t|
      t.integer :company_id
      t.string :file
      t.timestamps
    end
  end

  def down
    drop_table :directors
  end
end
