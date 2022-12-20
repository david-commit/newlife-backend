class AddDepartmentIdToPractitioner < ActiveRecord::Migration[7.0]
  def change
    add_reference :practitioners, :department, null: false, foreign_key: true
  end
end
