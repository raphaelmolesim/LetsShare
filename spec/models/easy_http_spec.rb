require "spec_helper"

describe EasyHttp do
  
  it "should successfully retreive an https url" do
    content = EasyHttp::get "https://www.google.com/accounts/ServiceLogin"
    expected = /\<title\>(\W|\s)*Google Accounts(\W|\s)*\<\/title\>/
    content.include?(expected).should be_true
  end
  
  it "should fail to retreive an unsafe http url" do 
    pending
    content = EasyHttp::get "http://www.google.com"
  end
  
end
  