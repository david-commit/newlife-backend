class ApplicationController < ActionController::API
  before_action :authorized
  
  def encode_token
  end

  def auth_header
  end

  def decoded_token
  end
end
