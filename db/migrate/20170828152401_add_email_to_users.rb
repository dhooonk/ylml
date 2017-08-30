class AddEmailToUsers < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :email, :string, :null => true
    remove_index :users, :email
  end
end
