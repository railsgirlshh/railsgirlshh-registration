class AttendeeApplication < ActiveRecord::Base
  include AASM
  include Tokenable

  belongs_to :event

  validates_presence_of :first_name, :last_name, :email, :event
  validates_uniqueness_of :token
  validates_format_of :email, :with => /@/
  validates :age, numericality: { only_integer: true }, allow_nil: true
  validates_acceptance_of :coc, allow_nil: false, on: :create

  enum status: [ :open, :accepted, :rejected, :on_waiting_list, :canceled ]

  scope :mailinglist_subscribers, -> { where(mailinglist_subscription: true) }

  aasm :column => :status, :enum => true do
    state :open, :initial => true
    state :accepted
    state :rejected
    state :on_waiting_list
    state :canceled

    event :get_accepted do
      after do
        AttendeeApplicationMailer.accepted_email(self).deliver
      end

      transitions :from => [:open, :on_waiting_list], :to => :accepted
    end

    event :get_rejected do
      after do
        AttendeeApplicationMailer.rejected_email(self).deliver
      end

      transitions :from => [:open, :on_waiting_list], :to => :rejected
    end
  end
end
