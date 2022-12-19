class CreateDepartmentPractitioners < ActiveRecord::Migration[7.0]
  def change
    create_table :department_practitioners do |t|
      t.belongs_to :department, null: false, foreign_key: true
      t.belongs_to :practitioner, null: false, foreign_key: true

      t.timestamps
    end
  end
end
