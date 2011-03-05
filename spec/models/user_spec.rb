require "spec_helper"

describe User, :type => :model do
  
  it "should create an instance of User" do
    User.new.class.should be == User
  end

  context "Username generation" do
    
    it "should create an username based in a good facebook link" do
      User.stub!(:find_by_username).and_return(nil)
      user = User.new
      user.username = "http://www.facebook.com/default.user"
      user.username.should be == "default.user"
    end
    
    it "should create an username based in a good facebook link with repetiton" do
      existent_user = mock_model(User)
      existent_user.stub!(:username).and_return("default.user")
      User.stub!(:find_by_username).and_return(existent_user)
      User.stub!(:where).and_return([existent_user])
      user = User.new
      user.username = "http://www.facebook.com/default.user"
      user.username.should be == "default.user1"
    end
    
    it "should create an username based in a good facebook link with 4 repetitons" do
      existent_user = mock_model(User)
      existent_user.stub!(:username).and_return("default.user")
      existent_users = [existent_user];
      (1..3).each do |i|  
        mocked_user = mock_model(User)
        mocked_user.stub!(:username).and_return("default.user#{i}")
        existent_users << mocked_user
      end
      User.stub!(:find_by_username).and_return(existent_user)
      User.stub!(:where).and_return(existent_users)
      user = User.new
      user.username = "http://www.facebook.com/default.user"
      user.username.should be == "default.user4"
    end
    
    it "should create an username based in a bad facebook link" do
      User.stub!(:find_by_username).and_return(nil)
      user = User.new
      user.name = "Default User"
      user.username = "http://www.facebook.com/profile.php=2387832083"
      user.username.should be == "default.user"
    end
    
    it "should create an username based in a bad facebook link with repetition" do
      existent_user = mock_model(User)
      existent_user.stub!(:username).and_return("default.user")
      User.stub!(:find_by_username).and_return(existent_user)
      User.stub!(:where).and_return([existent_user])
      user = User.new
      user.name = "Default User"
      user.username = "http://www.facebook.com/profile.php=2387832083"
      user.username.should be == "default.user1"
    end

    it "shouldn't create an username if a non link is passed" do
      User.stub!(:find_by_username).and_return(nil)
      user = User.new
      user.username = "default.user"
      user.username.should be == "default.user"
    end
    
    it "should create an username if a non link is passed but it has repetition" do
      existent_user = mock_model(User)
      existent_user.stub!(:username).and_return("default.user")
      User.stub!(:find_by_username).and_return(existent_user)
      User.stub!(:where).and_return([existent_user])
      user = User.new
      user.username = "default.user"
      user.username.should be == "default.user1"
    end
    
  end

  context "Create user based in json" do

    it "should create an instance of User based in a facebook hash" do
      User.stub!(:find_by_username).and_return(nil)
      hash = { "id" => "123456", "name" => "Default User", "email" => "default.user@gmail.com",
        "token" => "a1s2d3f4g5", "link" => "http://www.facebook.com/default.user"  }
      user = User.new_based_on_json hash
      user.name.should be == "Default User"
      user.email.should be == "default.user@gmail.com"
      user.username.should be == "default.user"
      user.facebook_id.should be == "123456"
      user.facebook_token.should be == "a1s2d3f4g5"
    end
  
    it "shouldn't create an instance of User based in a bad formated facebook hash" do
      lambda { User.new_based_on_json({}) }.should raise_exception
    end
  
  end

  context "Update user based in json" do

    it "should update an user based in a facebook hash" do
      user = User.new ({ :facebook_id => "123456", :name => "Default User", 
        :email => "default.user@gmail.com", :facebook_token => "a1s2d3f4g5",
        :username => "default.user" })
      user.id = 4
      user.update_based_on_json({ "id" => "123456", "token" => "1111",
          "name" => "User Default 1", "email" => "user.default1@gmail.com", 
          "link" => "http://www.facebook.com/default.user1"})
      
      user.id.should be == 4
      user.name.should be == "User Default 1"
      user.email.should be == "user.default1@gmail.com"
      user.facebook_token.should be == "1111"
      user.facebook_id.should be == "123456"
      user.username.should be == "default.user"
    end
  
    it "shouldn't update an user based in a bad formated facebook hash" do
      lambda { User.new_based_on_json({}) }.should raise_exception
    end
  
  end
  
  context "Get user by token" do
    
    it "should return a new user" do
      new_user = mock_model(User)
      new_user.stub!(:id).and_return(nil)
      Facebook.stub!(:get_user_info).and_return({:id => "38"})
      User.stub!(:find_by_facebook_id).and_return(nil)
      User.stub!(:new_based_on_json).and_return(new_user)
      user = User.get "123456"
      user.id.should be == nil
    end
    
    it "should return an existent user" do
      existent_user = mock_model(User)
      existent_user.stub!(:id).and_return(4)
      existent_user.stub!(:update_based_on_json).and_return(existent_user)
      Facebook.stub!(:get_user_info).and_return({:id => "38"})
      User.stub!(:find_by_facebook_id).and_return(existent_user)
      user = User.get "123456"
      user.id.should be == 4
    end

  end

end