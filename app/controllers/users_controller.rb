require 'net/https'
require 'open-uri'

class UsersController < ApplicationController
  before_filter :authenticate, :except => [ :create ]
  
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new params[:user]
    url = "https://graph.facebook.com/me?access_token=#{@user.facebook_token}"
    uri = URI.parse(URI.encode(url))
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    response = http.start { |request| request.get(url) }
    user_info = JSON response.body
    result = User.find_by_facebook_id user_info["id"]
    
    if (result.nil?)
      @user.facebook_id = user_info["id"]
      @user.name = user_info["name"]
      @user.email = user_info["email"]
      @user.save
    end
    
    session[:facebook_token] = @user.facebook_token
    
    redirect_to @user
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

end
