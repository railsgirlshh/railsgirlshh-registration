class AdminAccount < ActiveRecord::Base
  validates_presence_of :username, :password_sha1
end
