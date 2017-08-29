class AddMajorToCabinet < ActiveRecord::Migration[5.1]
  def change
    add_column :cabinets, :major, :string
  end
end
