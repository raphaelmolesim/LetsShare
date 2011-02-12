require 'uri'
require 'net/https'

class HomeController < ApplicationController
  
  before_filter :authenticated?, 
    :except => [ :login, :connect, :get_code, :get_access_token ]
  
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
      :client_id => client.client_id,
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
  
  def get_access_token
    puts "===========>#{params[:access_token]}"
    session[:access_token] = request.url
    render :text => request.session_options
    #redirect_to '/home/profile' 
  end
=begin
  def profile
    url = "https://graph.facebook.com/me?access_token=#{session[:access_token]}"
    b = get url
    
    render :text => url + " / body : #{b}"
  end
=end
end