class UsersController < ApplicationController
  before_filter :authenticate, :except => [ :create ]
  
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end
  
  def create
    @user = User.get params[:user][:facebook_token]
    @user.save
    session[:facebook_token] = @user.facebook_token
    redirect_to @user
  end
end
