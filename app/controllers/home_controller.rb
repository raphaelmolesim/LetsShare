require 'uri'

class HomeController < ApplicationController
  
  before_filter :authenticate, 
    :except => [ :login, :connect, :get_token, :url]
  
  def login
    render :login
  end

  def url action
    "http://letsshare.com:3000/home/#{action}"
  end

  def connect
    @domain = "https://www.facebook.com/"
    action = "#{@domain}dialog/oauth?"
    parameters = {
      :client_id => client[:client_id],
      :redirect_uri => url(:get_token),
      :scope  => 'user_about_me,email,user_photos,publish_stream',
      :response_type => 'token' }
    full_url = action + parameters.collect { |key, value| "#{key}=#{value}" }.join("&")
    puts "=========>" + full_url
    redirect_to URI.encode(full_url)
  end
  
  def get_token
    render :get_token
  end

end