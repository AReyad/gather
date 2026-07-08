# frozen_string_literal: true

module EventsHelper
  def display_time(time)
    time + if time > "11:59"
      " PM"
    else
      " AM"
    end
  end

  def attend_event_button(event)
    return link_to "Sign in to attend", signin_path unless user_signed_in?

    if event.past?
      content_tag(:p, "Event has ended")
    elsif event.attendees.include?(current_user)
      button_to "Leave Event", leave_event_path, method: :delete
    elsif event.public_event?
      button_to "Attend Event", attend_event_path
    elsif event.private_event?
      content_tag(:p, "Invitation Required")
    end
  end

  def user_authorized?
    event_host? && !@event.past?
  end

  def display_kick_button(attendee)
    return if @event.past?

    return unless event_host? && attendee.id != @event.host_id

    button_to "Kick", kick_user_path, method: :delete, params: { user_to_kick: attendee.id }, class: "kick-button",
                                      data: { turbo_confirm: "Are you sure you want to kick #{pretty_string(attendee.username)}?" }
  end

  def display_attendee(attendee)
   return "#{pretty_string(attendee.username)} (HOST)" if @event.host_id == attendee.id

   pretty_string(attendee.username)
  end

  def event_host?
    current_user && current_user.id == @event.host_id
  end
end
