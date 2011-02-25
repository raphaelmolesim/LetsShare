class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :authenticate
    
  protected
  
    def authenticate
      redirect_to :controller => "home", :action => params[:action] if not authenticated?
    end
  
  private
    
    def authenticated?
      if not session.include? "facebook_token"
        params[:action] = :access_denied
        return false 
      end
      result = !User.find_by_facebook_token(session["facebook_token"]).nil?
      params[:action] = :expired if not result
      result
    end
  
end
