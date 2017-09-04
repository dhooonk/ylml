class AddFeeOfSchToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :feeOfSch, :boolean
  end
end
