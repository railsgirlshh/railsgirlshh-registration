class CoachApplication < ActiveRecord::Base
  include Tokenable

  belongs_to :event

  validates_presence_of :first_name, :last_name, :email, :event
  validates_uniqueness_of :token
  validates_format_of :email, :with => /@/
  validates_acceptance_of :coc, allow_nil: false, on: :create

  enum status: [ :registered, :canceled ]

  scope :mailinglist_subscribers, -> { where(mailinglist_subscription: true) }
end
