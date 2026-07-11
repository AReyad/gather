# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_event, only: %i[show edit update destroy]
  before_action :authorize_user, only: %i[edit update destroy]
  before_action :check_event_date, only: %i[edit update destroy]
  before_action :authorize_private_event_view, only: [ :show ]

  def index
    @upcoming_events = Event.includes(:host).upcoming
    @past_events = Event.includes(:host).past
  end

  def show
    @attendees_count = @event.attendees.count
  end

  def new
    @event = Event.new
  end

  def edit; end

  def create
    @event = current_user.hosted_events.build(event_params)
    if @event.save
      @event.attendees << current_user
      redirect_to user_event_path(current_user.username, @event.id)
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @event.update(event_params)
      redirect_to user_event_path(current_user.username, @event.id)
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @event.destroy
    redirect_to root_path
  end

  private

  def event_params
    params.expect(event: %i[title description date time location privacy])
  end

  def set_event
    @user = User.find_by!(username: params.expect(:username))
    @event = @user.hosted_events.includes(:attendees).find(params.expect(:id))
  end

  def authorize_user
    redirect_to root_path and return unless event_host?
  end
end
