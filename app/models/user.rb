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
  
  def username=(link)
    @attributes["username"] = link.include?("http://") ? get_username_based_on_link(link) : link
  end
  
  def username
    @attributes["username"]
  end
    
  private
  
    def get_username_based_on_link link
      return generate_username if link.include? "profile.php"
      link.split("/").last
    end
  
    def generate_username
      username = self.name.downcase.gsub(" ", ".")
      user = User.find_by_username username
      return username if user.nil?
      same_name = User.where("username LIKE '#{username}%'")
      diff = same_name.collect { |u| u.username[username.length, u.username.length - username.length].to_i }
      id = diff.max + 1
      "#{username}#{id}"
    end
    
end
