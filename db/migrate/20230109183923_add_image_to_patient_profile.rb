class AddImageToPatientProfile < ActiveRecord::Migration[7.0]
  def change
    add_column :patient_profiles, :image, :string
  end
end
