class AddEmailToPatientProfile < ActiveRecord::Migration[7.0]
  def change
    add_column :patient_profiles, :email, :string
  end
end
