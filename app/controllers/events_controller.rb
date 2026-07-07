class EventsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_event, only: [ :show, :edit, :update ]
  before_action :authorize_user, only: [ :edit, :update ]
  def index
    @upcoming_events = Event.includes(:host).upcoming
    @past_events = Event.includes(:host).past
  end

  def show
  end

  def new
    @event = Event.new
  end

  def edit
  end

  def create
    @event = current_user.hosted_events.build(event_params)
    if @event.save
      @event.attendees << current_user
      redirect_to user_event_path(current_user.username, @event.id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
  end

  private

  def event_params
    params.expect(event: [ :title, :description, :date, :time, :location, :privacy ])
  end

  def set_event
    @user = User.find_by!(username: params[:username])
    @event = @user.hosted_events.includes(:attendees).find(params[:id])
  end

  def authorize_user
    unless event_host?
      redirect_to root_path and return
    end
  end
end
