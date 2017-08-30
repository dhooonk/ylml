class CreateTempusers < ActiveRecord::Migration[5.1]
  def change
    create_table :tempusers do |t|
      t.string :name
      t.string :stuN
      t.string :major
      t.string :identity
      t.timestamps
    end
  end
end
