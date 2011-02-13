class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :authenticate
    
  protected
  
    def authenticate
      redirect_to :controller => :home, :action => :login  if not authenticated?
    end
  
  private
    
    def authenticated?
      return false if not session.include? "facebook_token"
      not User.find_by_facebook_token(session["facebook_token"]).nil?
    end
  
end
