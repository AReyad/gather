# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user
  before_action :display_events

  def index; end
  def show; end

  private

  def set_user
    @user = User.find_by(username: params.expect(:username))
  end

  def display_events
    if params[:events_type] == "attending_events"
     @upcoming_events = upcoming_events(:attending)
     @past_events = past_events(:attending)
    else
     @upcoming_events = upcoming_events(:hosted)
     @past_events = past_events(:hosted)
    end
  end

  def upcoming_events(type)
    if type == :attending
      @user.attending_events.includes(:host).where.not(host_id: @user.id).upcoming
    else
      @user.hosted_events.includes(:host).upcoming
    end
  end

  def past_events(type)
    if type == :attending
      @user.attending_events.includes(:host).where.not(host_id: @user.id).past
    else
      @user.hosted_events.includes(:host).past
    end
  end
end
