class AddEmailToPractitionerProfile < ActiveRecord::Migration[7.0]
  def change
    add_column :practitioner_profiles, :email, :string
  end
end
