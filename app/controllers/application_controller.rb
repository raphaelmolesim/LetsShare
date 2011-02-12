require 'fbgraph'

class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :authenticated?,
    :except => [ :client ]
    
  protected

    def client      
      @client ||= FBGraph::Client.new(:client_id => '102507649823844',
                                      :secret_id => 'c75f7604c0aaf4168368e3ce7f43cfbc',
                                      :token => session[:access_token])
    end
    
    def authenticated?
      session.include? :access_token
    end
  
end
