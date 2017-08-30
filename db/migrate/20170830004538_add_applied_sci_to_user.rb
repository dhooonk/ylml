class AddAppliedSciToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :applied_sci_admin, :boolean, default: false
  end
end
