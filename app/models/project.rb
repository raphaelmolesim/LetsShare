class Project < ActiveRecord::Base
  belongs_to :owner, :class_name => "User", :foreign_key => "owner_id"
  has_and_belongs_to_many :users
  
  validates_presence_of :name, :owner 
  
end
