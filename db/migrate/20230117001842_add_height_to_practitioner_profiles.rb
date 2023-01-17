class AddHeightToPractitionerProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :practitioner_profiles, :height, :integer
  end
end
