class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.integer :zip
      t.string :city
      t.string :street
      t.integer :home_number
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
