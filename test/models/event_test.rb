require 'test_helper'
module EventTest
  class EventValidationTest < ActiveSupport::TestCase
    test "should save event with title and event date only" do
      event = Event.new(title: 'Summer workshop', event_date: Date.today+5)
      assert event.save, "Saved event with title and event date only"
    end

    test "should save event with full data" do
      event = Event.new(title: 'Summer workshop', description: 'Most awesome workshop ever', event_date: Date.today+5, coach_reg_start: Date.today+3, coach_reg_end: Date.today+4, attendee_reg_start: Date.today+3, attendee_reg_end: Date.today+4)
      assert event.save, "Saved event with title and event date only"
    end

    test "should not save event without title" do
      event = Event.new(event_date: Date.today+2)
      assert_not event.save, "Saved the event without a title"
    end

    test "should not save event without event date" do
      event = Event.new(title: 'Summer workshop')
      assert_not event.save, "Saved the event without an event date"
    end

    test "should not save event with attendee registration start after end" do
      event = Event.new(title: 'Summer workshop', event_date: Date.today+5, attendee_reg_start: Date.today+4, attendee_reg_end: Date.today+3)
      assert_not event.save, "Saved the event with attendee registration start after end"
    end

    test "should not save event with coach registration start after end"  do
      event = Event.new(title: 'Summer workshop', event_date: Date.today+5, coach_reg_start: Date.today+4, coach_reg_end: Date.today+3)
      assert_not event.save, "Saved the event with coach registration start after end"
    end

    test "should not create event with event date in the past"  do
      event = Event.new(title: 'Summer workshop', event_date: Date.today-5)
      assert_not event.save, "Created the event with event date in the past"
    end

    test "should update event with event date in the past"  do
      event = Event.new(title: 'Summer workshop', event_date: Date.today+5)
      event.save
      event.event_date= Date.today-2
      assert event.save, "Updated the event with event date in the past"
    end
  end

  class IsOverTest < ActiveSupport::TestCase
    test 'should return true if event date is in the past' do
      event = events(:past_event)
      assert event.is_over?, 'is_over? is true for past event'
    end

    test 'should return false if event is in the future' do
      event = events(:minimal_event)
      assert_not event.is_over?, 'is_over? is false for future event'
    end

    test 'should return false if event is today' do
      event = events(:minimal_event)
      event.event_date= Date.today
      event.save
      assert_not event.is_over?, "is_over? is false for today's event"
    end
  end
end
