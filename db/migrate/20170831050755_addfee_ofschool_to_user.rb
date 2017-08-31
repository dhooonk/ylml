class AddfeeOfschoolToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :tempusers, :feeOfSch, :boolean
  end
end
