class UsersController < ApplicationController
  before_action :set_user
  before_action :display_events
  def show
  end

  private

  def set_user
    @user = User.find_by(username: params[:username])
  end

  def set_hosted_events
    @hosted_events = @user.hosted_events.includes(:host)
  end

  def set_attending_events
    @attending_events = { past_events: @user.attending_events.includes(:host).where("host_id != ?", @user.id).past_event,
                          upcoming_events: @user.attending_events.includes(:host).where("host_id != ?", @user.id).upcoming_event }
  end

  def display_events
    if params[:events_type] == "attending_events"
     @events = set_attending_events
    else
     @events = set_hosted_events
    end
  end
end
