class CreateLimits < ActiveRecord::Migration[5.1]
  def change
    create_table :limits do |t|
      t.string :student_time
      
      t.string :gda_time

      t.timestamps
    end
  end
end
