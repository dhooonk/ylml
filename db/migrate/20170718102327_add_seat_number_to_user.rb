class AddSeatNumberToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :seatNumber, :string
  end
end
