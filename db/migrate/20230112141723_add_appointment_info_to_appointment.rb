class AddAppointmentInfoToAppointment < ActiveRecord::Migration[7.0]
  def change
    add_column :appointments, :appointment_info, :string
  end
end
