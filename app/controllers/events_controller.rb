class EventsController < ApplicationController
  load_and_authorize_resource

  before_action :set_event, only: %i[ show edit update archive delete register]
  before_action :set_enrollment, only: %i[ show unregister]

  # GET /events or /events.json
  def index
    if params[:user_id]
      @events = Event.joins(:enrollments).where(status: :active, enrollments: { user_id: params[:user_id] })
    else
      @events = Event.active
    end
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
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: "Event was successfully updated" }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def archive
    respond_to do |format|
      if @event.update(status: :archived)
        format.html { redirect_to @event, notice: "Event successfully archived" }
      else
        format.html { redirect_to @event, notice: "Only past events can by archived" }
      end
    end
  end

  def delete
    respond_to do |format|
      if @event.update(status: :deleted)
        format.html { redirect_to @event, notice: "Event successfully deleted" }
      else
        format.html { redirect_to @event, notice: "Only fuature events can by deleted" }
      end
    end
  end

  def register
    @enrollment = Enrollment.new(user_id: current_user.id, event_id: @event.id)

    respond_to do |format|
      if @enrollment.save
        format.html { redirect_to @event, notice: "Register was successfully" }
      else
        format.html { redirect_to @event, notice:  @enrollment.errors.full_messages }
      end
    end
  end

  def unregister
    @enrollment.destroy!

    respond_to do |format|
      format.html { redirect_to @event, notice: "Unregister successfully" }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  def set_enrollment
    @enrollment = Enrollment.find_by(user_id: current_user.id, event_id: @event.id)
  end

  # Only allow a list of trusted parameters through.
  def event_params
    params.require(:event).permit(:name, :date, :description, :place, :capacity, :category, :status)
  end
end
