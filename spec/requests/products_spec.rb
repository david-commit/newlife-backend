require 'rails_helper'

RSpec.describe "Products", type: :request do

  it "can be viewed" do

    headers = {"Accept": "application/json"}
    get '/products'
    
    expect(JSON.parse(response.body)).to be_kind_of(Array)
  end
end
