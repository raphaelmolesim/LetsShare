class User < ActiveRecord::Base
  include EasyHttp
  
  def self.get facebook_token
    user_info = Facebook.get_user_info facebook_token
    user = User.find_by_facebook_id user_info["id"]
    return user if not user.nil?
    User.new user_info, facebook_token
  end
  
  def self.new json_data, token
    user = User.new
    attributes = user.attributes.keys.find_all { |attr| facebook_attribute? attr }
    attributes.each { |attr| eval "user.#{attr} = json_data[\"#{attr}\"]" }
    user.facebook_id = json_data["facebook_id"]
    user.facebook_token = token
    user
  end
  
  def facebook_attribute? attribute
    not attribute.include? "facebook" and attribute.include? "at"
  end
  
end
