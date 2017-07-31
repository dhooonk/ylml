class AddStuNToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :stuN, :integer
  end
end
