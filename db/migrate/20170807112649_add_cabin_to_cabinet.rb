class AddCabinToCabinet < ActiveRecord::Migration[5.1]
  def change
    add_column :cabinets, :cabins, :string
  end
end
