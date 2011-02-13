class HomeController < ApplicationController
  
  before_filter :authenticate, 
    :except => [ :login, :connect, :get_token]
  
  def login
  end

  def connect
    redirect_to Facebook.authorization_url
  end
  
  def get_token
  end

end