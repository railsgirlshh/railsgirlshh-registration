class AttendeeApplication < ActiveRecord::Base
  belongs_to :event
  
  validates_presence_of :first_name, :last_name, :email, :event

end
