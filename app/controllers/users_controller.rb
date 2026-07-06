class UsersController < ApplicationController
  before_action :set_user
  before_action :display_events
  def show
  end

  def index
  end

  private

  def set_user
    @user = User.find_by(username: params[:username])
  end

  def display_events
    if params[:events_type] == "attending_events"
     @upcoming_events = @user.attending_events.includes(:host).where("host_id != ?", @user.id).upcoming
     @past_events = @user.attending_events.includes(:host).where("host_id != ?", @user.id).past
    else
     @upcoming_events = @user.hosted_events.includes(:host).upcoming
     @past_events = @user.hosted_events.includes(:host).past
    end
  end
end
