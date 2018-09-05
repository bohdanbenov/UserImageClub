class ChangeTableUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column(:users, :name, :first_name)
    rename_column(:users, :lastname, :last_name)
    change_table(:users) do |t|
      t.column :age, :integer
      t.column :sex, :string
      t.column :about, :text
    end
  end
end
