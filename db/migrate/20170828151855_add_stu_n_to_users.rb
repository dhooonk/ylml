class AddStuNToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :stuN, :string
    add_index :users, :stuN, unique: true
  end
end
