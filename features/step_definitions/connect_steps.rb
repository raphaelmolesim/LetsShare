require "features/helpers/test_helper"

Given /^an user not registered that wants to connect with a faceboook account$/ do
  visit home_path
end

Given /^with username "([^\"]*)"$/ do |arg1|
  
end

Given /^password "([^\"]*)"$/ do |arg1|
  
end

When /^he click in connect$/ do
  
end

Then /^I should connect him to the facebook$/ do
  
end








=begin
Given /^an user not registered that wants to connect with a facebook account$/ do
  open home_path
end

Given /^with username "([^\"]*)"$/ do |username|
  @username = username
end

Given /^password "([^\"]*)"$/ do |password|
  @password = password
end

When /^he click in connect$/ do
  click "a[name=sign_in]"
end

Then /^I should connect him to the facebook$/ do
  
end

=end