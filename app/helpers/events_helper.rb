module EventsHelper
  def display_time(time)
    if time > "11:59"
      time += " PM"
    else
      time += " AM"
    end
  end

  def attend_event_button(event)
    return "Sign in to attend" unless user_signed_in?

    if event.attendees.include?(current_user)
      button_to "Leave Event", leave_event_path, method: :delete
    elsif event.public_event?
      button_to "Attend Event", attend_event_path
    elsif event.private_event?
      content_tag(:p, "Invitation Required")
    end
  end

  def user_can_invite?(event)
    event.private_event? && current_user.id == event.host_id
  end
end
