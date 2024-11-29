class EventsController < ApplicationController
  load_and_authorize_resource

  before_action :set_event, only: %i[ show edit update archive ]

  # GET /events or /events.json
  def index
    @events = Event.active
  end

  # GET /events/1 or /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events or /events.json
  def create
    @event = current_user.events.build(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: "Event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: "Event was successfully updated" }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def archive
    respond_to do |format|
      if @event.update(status: :archived)
        format.html { redirect_to @event, notice: "Event successfully archived" }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { redirect_to @event, notice: "Only past events can by archived" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete
    respond_to do |format|
      if @event.update(status: :deleted)
        format.html { redirect_to @event, notice: "Event successfully deleted" }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { redirect_to @event, notice: "Only fuature events can by deleted" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def event_params
    params.require(:event).permit(:name, :date, :description, :place, :capacity, :category, :status)
  end
end
