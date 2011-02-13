class UsersController < ApplicationController
  before_filter :authenticate, :except => [ :create ]
  
  def profile
    @user = User.find_by_username(params[:username])
    render :action => "user_not_found",
           :locals => { :username => params[:username] } if (@user.nil?)
  end
  
  def create
    @user = User.get params[:user][:facebook_token]
    @user.save
    session[:facebook_token] = @user.facebook_token
    redirect_to "/#{@user.username}"
  end
end
