class AddIdentityToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :identity, :string
  end
end
