class RenameColumnFacebookToken < ActiveRecord::Migration
  def self.up
    rename_column :users, :facebook_token, :facebook_id
  end

  def self.down
    rename_column :users, :facebook_id, :facebook_token
  end
end
