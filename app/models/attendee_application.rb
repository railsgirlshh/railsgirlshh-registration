class AttendeeApplication < ActiveRecord::Base
  belongs_to :event
  
  validates_presence_of :first_name, :last_name, :email, :event

  enum status: [ :open, :accepted, :rejected, :on_waiting_list, :canceled ]

end
