class EventAttendingsController < ApplicationController
  before_action :set_event, only: [ :create, :destroy ]
  before_action :authenticate_user!, only: [ :create, :destroy  ]
  before_action :authorize_user, only: [ :create ]

  def create
    EventAttending.create(attending_event_params)
    redirect_to user_event_path(params[:username], params[:id])
  end

  def destroy
    @event.attendees.destroy(current_user.id)
    redirect_to user_event_path(params[:username], params[:id])
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def attending_event_params
    if @event.private_event? && authorized_user?
      user_id = User.find_by!(username: params[:invite_user]).id
    elsif @event.public_event?
      user_id = current_user.id
    end
    { event_attendee_id: user_id, attended_event_id: params[:id] }
  end

  def authorize_user
    unless @event.public_event? || authorized_user?
      redirect_to signin_path
    end
  end

  def authorized_host?
    current_user.id == @event.host_id
  end
end
