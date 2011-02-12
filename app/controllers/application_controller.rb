class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :authenticate,
    :except => [ :client ]
    
  protected

    def client      
      @client ||= { :client_id => '102507649823844',
                    :secret_id => 'c75f7604c0aaf4168368e3ce7f43cfbc' }
    end
  
    def authenticate
      redirect_to :controller => :home, :action => :login  if not authenticated?
    end
  
  private
    
    def authenticated?
      return false if not session.include? :facebook_token
      not User.find_by_facebook_token(session[:facebook_token]).nil?
    end
  
end
