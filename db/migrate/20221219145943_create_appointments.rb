class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :practitioner, null: false, foreign_key: true
      t.date :date
      t.boolean :approved
      t.string :appointment_type

      t.timestamps
    end
  end
end
