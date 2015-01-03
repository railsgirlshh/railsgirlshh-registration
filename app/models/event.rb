class Event < ActiveRecord::Base
  has_many :attendee_applications
  has_many :coach_applications

  validates_presence_of :title, :event_date

  validates_each :coach_reg_start, :coach_reg_end, :attendee_reg_start, :attendee_reg_end, :coach_dinner_date do |record, attr, value|
    record.errors.add(attr, 'must be before event date') if value.present? && value > record.event_date
  end

  validate :coach_reg_valid
  validate :attendee_reg_valid

  validates_each :event_date, :coach_dinner_date, on: :create do |record, attr, value|
    record.errors.add(attr, "must be in the future") if value.present? && value < Date.today 
  end

  def is_over?
    event_date < Date.today
  end

  def coach_reg
    @coach_reg ||= ApplicationPeriod.new(coach_reg_start, coach_reg_end || event_date)
  end

  def attendee_reg
    @attendee_reg ||= ApplicationPeriod.new(attendee_reg_start, attendee_reg_end || event_date)
  end

  private

  def coach_reg_valid
    errors.add(:coach_reg_end, "must be after the coach reg start")  unless coach_reg.valid?
  end

  def attendee_reg_valid
    errors.add(:attendee_reg_end, "must be after the attendee reg start") unless attendee_reg.valid?
  end
end

class ApplicationPeriod
  attr_reader :start_date, :end_date

  def initialize(start_date,end_date)
    @start_date = start_date
    @end_date   = end_date
  end

  def open?
    return false if end_date.present? && end_date < Date.today
    return true if start_date.blank?
    start_date <= Date.today
  end

  def not_started?
    start_date.present? && start_date > Date.today
  end

  def already_closed?
    end_date.present? && end_date < Date.today
  end

  def valid?
    return true if start_date.blank? || end_date.blank?
    return false if end_date < start_date
    return true
  end
end
