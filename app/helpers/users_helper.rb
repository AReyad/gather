module UsersHelper
  def display_user_events_header(events)
    host_username = event_host(@events.first)
    if current_user && host_username == current_user.username
     "Your events"
    else
     "#{pretty_username(host_username)}'s events"
    end
  end

  def pretty_username(username)
    username.capitalize
  end
end
