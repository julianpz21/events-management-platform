class Api::V1::EventsController < Api::BaseController
  before_action :set_event, only: %i[ update archive delete ]
  before_action :set_enrollment, only: %i[ unregister]


  def index
    if params[:user_id]
      @events = Event.joins(:enrollments).where(status: :active, enrollments: { user_id: params[:user_id] })
    else
      @events = Event.active
    end

    render json: @events
  end

  def create
    @event = User.find(params[:user_id]).events.build(event_params)

    if @event.save
      render json: @event, status: :ok
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  def update
    if @event.update(event_params)
      render json: @event, status: :ok
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  def archive
    if @event.update(status: :archived)
      render json: @event, status: :ok
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  def delete
    if @event.update(status: :deleted)
      render json: @event, status: :ok
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  def register
    @enrollment = Enrollment.new(user_id: params[:user_id], event_id: params[:id])

    if @enrollment.save
      render json: @enrollment, status: :ok
    else
      render json: @enrollment.errors, status: :unprocessable_entity
    end
  end

  def unregister
    if @enrollment&.destroy
      render json: @enrollment, status: :ok
    else
      render json: { error: "Not found" }, status: :not_found
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :date, :description, :place, :capacity, :category, :status)
  end

  def set_enrollment
    @enrollment = Enrollment.find_by(user_id: params[:user_id], event_id: params[:id])
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
