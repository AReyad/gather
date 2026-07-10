# frozen_string_literal: true

module UsersHelper
  def display_user_header(user, type)
    if current_user && user.username == current_user.username
     "Your #{type} events"
    else
     "#{user.username}'s #{type} events"
    end
  end
end
