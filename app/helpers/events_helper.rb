module EventsHelper
  def display_time(time)
    if time > "11:59"
      time += " PM"
    else
      time += " AM"
    end
  end

  def event_host(event)
    event.host.username
  end

  def pretty_event_host(event)
    event_host(event).capitalize
  end
end
