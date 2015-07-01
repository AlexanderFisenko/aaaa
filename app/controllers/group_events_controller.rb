class API::GroupEventsController < ApplicationController
  before_filter :set_group_event, only: [:show, :edit, :update, :destroy]

  respond_to :json

  def index
    @group_events = GroupEvent.all

    respond_to do |format|
      format.json { render json: @group_events }
    end
  end

  def show
    respond_to do |format|
      format.json { render json: @group_event }
    end
  end

  def edit
    respond_to do |format|
      format.json { render json: @group_event }
    end
  end

  def create
    @group_event = GroupEvent.new(group_event_params)

    if ready_for_automatic_starts_at_set?
      @group_event.starts_at = @group_event.ends_at - @group_event.duration.days
    end

    if ready_for_automatic_ends_at_set?
      @group_event.ends_at = @group_event.starts_at + @group_event.duration.days
    end

    if ready_for_automatic_duration_set?
      @group_event.duration = (@group_event.ends_at - @group_event.starts_at).to_i
    end

    @group_event.save
  end

  def update
    @group_event.update(group_event_params)

    if ready_for_automatic_starts_at_set?
      @group_event.update(starts_at: @group_event.ends_at - @group_event.duration.days)
    end

    if ready_for_automatic_ends_at_set?
      @group_event.update(ends_at: @group_event.starts_at + @group_event.duration.days)
    end

    if ready_for_automatic_duration_set?
      @group_event.update(duration: (@group_event.ends_at - @group_event.starts_at).to_i)
    end
  end

  def destroy
    @group_event.update state: :deleted
  end


  private

  def group_event_params
    params.require(:group_event).permit(
      :name,
      :description,
      :location,
      :aasm_state,
      :duration,
      :starts_at,
      :ends_at,
    ).merge(description: markdown(@group_event.description))
  end

  def set_group_event
    @group_event = GroupEvent.find(params[:id])
  end

  def ready_for_automatic_starts_at_set?
    @group_event.starts_at.empty? && 
      @group_event.ends_at.present? &&
        @group_event.duration.present?
  end

  def ready_for_automatic_ends_at_set?
    @group_event.ends_at.empty? && 
      @group_event.starts_at.present? &&
        @group_event.duration.present?
  end

  def ready_for_automatic_duration_set
    @group_event.duration.empty? && 
      @group_event.starts_at.present? &&
        @group_event.ends_at.present?
  end
  
end
