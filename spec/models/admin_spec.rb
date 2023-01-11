require 'rails_helper'

RSpec.describe Admin, type: :model do
  it "can be created with valid data" do
    Admin.destroy_all
    admin = Admin.create!(
      username: "admin",
      password: "Passw0rd3",
      email: "admin@newlife.com"
    )

    expect(admin.id.nil?).to eql(false)
  end

  it "can be updated" do
    Admin.destroy_all
    admin = Admin.create!(
      username: "admin",
      password: "Passw0rd3",
      email: "admin@newlife.com"
    )

    admin.update(username: "new")

    expect(admin.username).to eql("new")
  end

  it "can be destroyed" do
    Admin.destroy_all
    admin = Admin.create!(
      username: "admin",
      password: "Passw0rd3",
      email: "admin@newlife.com"
    )

    admin_id = admin.id
    admin.destroy
    expect{Admin.find(admin_id)}.to raise_error ActiveRecord::RecordNotFound
  end
end
