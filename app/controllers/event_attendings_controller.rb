class EventAttendingsController < ApplicationController
  before_action :set_event, only: [ :create, :destroy ]
  before_action :authenticate_user!, only: [ :create, :destroy  ]
  before_action :authorize_user, only: [ :create ]
  before_action :check_event_date, only: [ :create, :destroy  ]

  def create
    EventAttending.create(attending_event_params)
    redirect_to_event
  end

  def destroy
    @event.attendees.destroy(kick_user_params)
    redirect_to_event
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def attending_event_params
    if event_host?
      user_id = User.find_by!(username: params[:invite_user]).id
    elsif @event.public_event?
      user_id = current_user.id
    end
    { event_attendee_id: user_id, attended_event_id: params[:id] }
  end

  def kick_user_params
    if event_host? && params[:user_to_kick].to_i == @event.host_id
      redirect_to root_path  and return
    elsif event_host?
      params[:user_to_kick]
    else
      current_user.id
    end
  end

  def authorize_user
    unless @event.public_event? || event_host?
      redirect_to root_path and return
    end
  end

  def redirect_to_event
    redirect_to user_event_path(@event.host_id, @event.id) and return
  end
end
