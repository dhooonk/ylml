class CreateCabinets < ActiveRecord::Migration[5.1]
  def change
    create_table :cabinets do |t|
      t.timestamps
    end
  end
end
