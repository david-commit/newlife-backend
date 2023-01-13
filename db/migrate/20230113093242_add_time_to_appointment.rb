class AddTimeToAppointment < ActiveRecord::Migration[7.0]
  def change
    add_column :appointments, :time, :string
  end
end
