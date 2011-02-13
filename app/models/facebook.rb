require 'open-uri'

module Facebook

  def self.get_user_info token
    url = "https://graph.facebook.com/me?access_token=#{token}"
    json_data = EasyHttp.get url
    user_info = parse_to_hash json_data
    user_info["token"] = token
    user_info 
  end
  
  def self.authorization_url
    action = "https://www.facebook.com/dialog/oauth?"
    parameters = {
      :client_id => client_id,
      :redirect_uri => redirect_url(:get_token),
      :scope  => 'user_about_me,email,user_photos,publish_stream',
      :response_type => 'token' }
    return URI.encode(action + parameters.collect { |key, value| "#{key}=#{value}" }.join("&"))
  end
  
  private
  
    def self.redirect_url action
      "http://letsshare.com:3000/home/#{action}"
    end
    
    def self.parse_to_hash json_data
      hash_data = JSON json_data
      return hash_data if valid? hash_data
      raise "Message: #{hash_data["error"]["message"]}"
    end
    
    def self.valid? json 
      not json.include? "error"
    end
    
    def self.client_id
      '102507649823844'
    end

    def self.secret_id
      'c75f7604c0aaf4168368e3ce7f43cfbc'
    end
end