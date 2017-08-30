class AddTimeToLimits < ActiveRecord::Migration[5.1]
  def change
    add_column :limits, :student_time_, :string
    add_column :limits, :gda_time_,     :string
  end
end
