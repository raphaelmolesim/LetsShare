class UsersController < ApplicationController
  before_filter :authenticate, :except => [ :create ]
  
  def profile
    @user = User.find_by_username(params[:username])
    render :action => "user_not_found",
           :locals => { :username => params[:username] } if (@user.nil?)
  end
  
  def my_profile
    @user = User.find(session["user_id"])
    redirect_to "/#{@user.username}"
  end
  
  def home
    @user = User.find(session["user_id"])
    render :action => "error" if @user.nil?
  end
  
  def create
    @user = User.get params[:user][:facebook_token]
    @user.save
    session[:facebook_token] = @user.facebook_token
    redirect_to "/me"
  end
  
  def invite
    @project = Project.find(params[:project_id])
  end
  
  def search
    @users = User.where("name LIKE ?", "%#{params[:user][:name]}%")
  end

end
