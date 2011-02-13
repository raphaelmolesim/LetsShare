class User < ActiveRecord::Base
  
  def self.get facebook_token
    user_info = Facebook.get_user_info facebook_token
    user = User.find_by_facebook_id user_info["id"]
    return user if not user.nil?
    User.new_based_on_json user_info
  end
  
  def self.new_based_on_json json_data
    user = User.new 
    attributes = user.attributes.keys.find_all { |attr| facebook_attribute? attr }
    attributes.each { |attr| eval "user.#{attr} = json_data[\"#{attr}\"]" }
    user.facebook_id = json_data["id"]
    user.facebook_token = json_data["token"]
    user.username = json_data["link"]
    user
  end
  
  def self.facebook_attribute? attribute
    not attribute.include? "facebook" and not attribute.include? "at" and not attribute.include? "username"
  end
  
  def username link
    if link.include? "profile.php"
      self.username = generate_username 
    elsif link.include? "facebook.com"
      self.username = link.split("/").last
    else
      self.username = link
    end
  end
  
  def generate_username
    username = self.name.downcase.gsub(" ", ".")
    user = User.find_by_username username
    return username if user.nil?
    
  end
  
end
