class AddCabinToCabinetr < ActiveRecord::Migration[5.1]
  def change
    add_column :cabinets, :cabin, :string
  end
end
