class AttendeeApplication < ActiveRecord::Base
  include Tokenable

  belongs_to :event

  validates_presence_of :first_name, :last_name, :email, :event
  validates_uniqueness_of :token

  enum status: [ :open, :accepted, :rejected, :on_waiting_list, :canceled ]
end
