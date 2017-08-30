class CreateCabinetImes < ActiveRecord::Migration[5.1]
  def change
    create_table :cabinet_imes do |t|
      t.belongs_to :user
      t.string :cabins_ime
      t.timestamps
    end
  end
end
