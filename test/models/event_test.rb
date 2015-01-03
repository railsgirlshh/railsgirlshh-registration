require 'test_helper'
module EventTest
  class EventValidationTest < ActiveSupport::TestCase
    test "should save event with title and event date only" do
      event = Event.new(title: 'Summer workshop', event_date: Date.today+5)
      assert event.save, "Saved event with title and event date only"
    end

    test "should save event with full data" do
      event = Event.new(title: 'Summer workshop', description: 'Most awesome workshop ever', event_date: Date.today+5, coach_dinner_date: Date.today+4, coach_reg_start: Date.today+3, coach_reg_end: Date.today+4, attendee_reg_start: Date.today+3, attendee_reg_end: Date.today+4)
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

    test "should not create event with coach dinner date in the past"  do
      event = Event.new(title: 'Summer workshop', event_date: Date.today+5, coach_dinner_date: Date.today-2)
      assert_not event.save, "Created the event with coach dinner date in the past"
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

  class CoachRegEndDateTest < ActiveSupport::TestCase
    test 'expects event date if no end given' do
      event = events(:minimal_event)
      assert_equal event.coach_reg.end_date, event.event_date, 'expects event date if no end given'
    end

    test 'expects end if not blank' do
      event = events(:minimal_event)
      event.coach_reg_end= Date.today+2
      assert_equal event.coach_reg_end, event.coach_reg.end_date, 'expects end if not blank'
    end
  end

  class CoachRegOpenTest < ActiveSupport::TestCase
    test 'expects true if no start or end' do
      event = events(:minimal_event)
      assert event.coach_reg.open?, 'should be true if start and end empty'
    end

    test 'expects true if no start and end in the future' do
      event = events(:minimal_event)
      event.coach_reg_end= Date.today + 2
      assert event.coach_reg.open?, 'should be true if end in the future'
    end

    test 'expects true if start in the past end end date in the future' do
      event = events(:minimal_event)
      event.coach_reg_start= Date.today - 2
      event.coach_reg_end= Date.today + 2
      assert event.coach_reg.open?, 'should be true if start in the past, end in the future'
    end

    test 'expects true if start date in the past, no end, end event in the future' do
      event = events(:minimal_event)
      event.coach_reg_start= Date.today - 2
      assert event.coach_reg.open?, 'should be true if start in the past and no end given'
    end

    test 'expects false if event is over' do
      event = events(:past_event)
      assert_not event.coach_reg.open?, 'should be false if event is over'
    end

    test 'expects false if start is in the future' do
      event = events(:minimal_event)
      event.coach_reg_start= Date.today + 2
      assert_not event.coach_reg.open?, 'should be false if start is in the future'
    end

    test 'expects false if end is in the past' do
      event = events(:minimal_event)
      event.coach_reg_end= Date.today - 2
      assert_not event.coach_reg.open?, 'should be false if end is in the past'
    end
  end

  class AttendeeRegEndDateTest < ActiveSupport::TestCase
    test 'expects event date if no end given' do
      event = events(:minimal_event)
      assert_equal event.event_date, event.attendee_reg.end_date, 'expects event date if no end given'
    end

    test 'expects end if not blank' do
      event = events(:minimal_event)
      event.attendee_reg_end= Date.today+2
      assert_equal event.attendee_reg_end, event.attendee_reg.end_date, 'expects end if not blank'
    end
  end

  class AttendeeRegOpenTest < ActiveSupport::TestCase
    test 'expects true if no start or end' do
      event = events(:minimal_event)
      assert event.attendee_reg.open?, 'should be true if start and end empty'
    end

    test 'expects true if no start and end in the future' do
      event = events(:minimal_event)
      event.attendee_reg_end= Date.today + 2
      assert event.attendee_reg.open?, 'should be true if end in the future'
    end

    test 'expects true if start in the past end end date in the future' do
      event = events(:minimal_event)
      event.attendee_reg_start= Date.today - 2
      event.attendee_reg_end= Date.today + 2
      assert event.attendee_reg.open?, 'should be true if start in the past, end in the future'
    end

    test 'expects true if start date in the past, no end, end event in the future' do
      event = events(:minimal_event)
      event.attendee_reg_start= Date.today - 2
      assert event.attendee_reg.open?, 'should be true if start in the past and no end given'
    end

    test 'expects false if event is over' do
      event = events(:past_event)
      assert_not event.attendee_reg.open?, 'should be false if event is over'
    end

    test 'expects false if start is in the future' do
      event = events(:minimal_event)
      event.attendee_reg_start= Date.today + 2
      assert_not event.attendee_reg.open?, 'should be false if start is in the future'
    end

    test 'expects false if end is in the past' do
      event = events(:minimal_event)
      event.attendee_reg_end= Date.today - 2
      assert_not event.attendee_reg.open?, 'should be false if end is in the past'
    end
  end
end
