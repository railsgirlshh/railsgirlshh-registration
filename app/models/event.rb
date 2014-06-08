class Event < ActiveRecord::Base
  has_many :attendee_applications
  validates_presence_of :title, :event_date

  validates_each :coach_reg_start, :coach_reg_end, :attendee_reg_start, :attendee_reg_end do |record, attr, value|
    record.errors.add(attr, 'must be before event date') if value.present? && value > record.event_date
  end

  validate :coach_reg_end_after_start
  validate :attendee_reg_end_after_start

  validate :event_in_the_future, on: :create

  def is_over?
    event_date < Date.today
  end

  def coach_reg_end_date
    coach_reg_end || event_date
  end

  def attendee_reg_end_date
    attendee_reg_end || event_date
  end

  def coach_reg_open?
    reg_open?(coach_reg_start,coach_reg_end_date)
  end

  def attendee_reg_open?
    reg_open?(attendee_reg_start,attendee_reg_end_date)
  end

  private

  def reg_open?(start_date,end_date)
    return false if end_date < Date.today
    return true if start_date.blank?
    start_date <= Date.today
  end

  def event_in_the_future
    return if event_date.blank?
    errors.add(:event_date, "must be in the future") if event_date < Date.today 
  end

  def coach_reg_end_after_start
    return if coach_reg_end.blank? || coach_reg_start.blank?
 
    if coach_reg_end < coach_reg_start
      errors.add(:coach_reg_end, "must be after the coach reg start") 
    end 
  end

  def attendee_reg_end_after_start
    return if attendee_reg_end.blank? || attendee_reg_start.blank?
 
    if attendee_reg_end < attendee_reg_start
      errors.add(:attendee_reg_end, "must be after the attendee reg start") 
    end 
  end
end
