class CreateCabinetApliScis < ActiveRecord::Migration[5.1]
  def change
    create_table :cabinet_apli_scis do |t|
      t.belongs_to :user
      t.string :cabins_aplsci
      t.timestamps
    end
  end
end
