class AddImageToPractitionerProfile < ActiveRecord::Migration[7.0]
  def change
    add_column :practitioner_profiles, :image, :string
  end
end
