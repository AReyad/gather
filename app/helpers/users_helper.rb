module UsersHelper
  def display_user_header(user, type)
    if current_user && user.username == current_user.username
     "Your #{type} events"
    else
     "#{pretty_string(user.username)}'s #{type} events"
    end
  end
end
