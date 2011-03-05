class User < ActiveRecord::Base
  
  has_many :my_projects, :class_name => "Project", :foreign_key => "owner_id"
  has_and_belongs_to_many :projects
  
  def self.get facebook_token
    user_info = Facebook.get_user_info facebook_token
    user = User.find_by_facebook_id user_info["id"]
    return user.update_based_on_json(user_info) if not user.nil?
    User.new_based_on_json user_info
  end
  
  def self.new_based_on_json json_data
    user = User.new 
    begin
      attributes = user.attributes.keys.find_all { |attr| facebook_attribute? attr }
      attributes.each { |attr| eval "user.#{attr} = json_data[\"#{attr}\"]" }
      user.facebook_id = json_data["id"]
      user.facebook_token = json_data["token"]
      user.username = json_data["link"]
    rescue
      raise "Bad facebook json fomatation: #{json_data.to_s}"
    end
    user
  end
  
  def self.facebook_attribute? attribute
    [:facebook, :username, :at].collect { |str| return false if attribute.include?(str) }
    attribute != "id"
  end
  
  def update_based_on_json json_data
    begin
      attributes = self.attributes.keys.find_all { |attr| User.facebook_attribute? attr }
      attributes.each { |attr| eval "self.#{attr} = json_data[\"#{attr}\"]" }
      self.facebook_id = json_data["id"]
      self.facebook_token = json_data["token"]
    rescue
      raise "Bad facebook json fomatation: #{json_data.to_s}"
    end
    self
  end
  
  def username=(link)
    if link.include?("http://")
      @attributes["username"] = get_username_based_on_link link
    else
      @attributes["username"] = check_and_generate_username link
    end
  end
  
  def username
    @attributes["username"]
  end
    
  private
  
    def get_username_based_on_link link
      candidate = (not link.include?("profile.php")) ? link.split("/").last : nil
      return check_and_generate_username candidate
    end
  
    def check_and_generate_username candidate
      username = candidate.nil? ? self.name.downcase.gsub(" ", ".") : candidate
      return username if not User.username_exists? username
      User.next_username username
    end
    
    def self.username_exists? username
      not User.find_by_username(username).nil?
    end
    
    def self.find_by_username_that_starts_with username
      User.where("username LIKE '#{username}%'")
    end
    
    def self.next_username username
      users = User.find_by_username_that_starts_with username
      usernames = users.collect { |u| u.username }
      length = username.length
      diff = usernames.collect { |u| u[length, u.length - length].to_i }
      id = diff.max + 1
      "#{username}#{id}"
    end
    
end
