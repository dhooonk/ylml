class CreateCabinetEnis < ActiveRecord::Migration[5.1]
  def change
    create_table :cabinet_enis do |t|
      t.belongs_to :user
      t.string :cabins_eni
      t.timestamps
    end
  end
end
