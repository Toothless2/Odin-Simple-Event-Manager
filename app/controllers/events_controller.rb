class EventsController < ApplicationController
  before_action :checkLogin
  before_action :getLoggedInUser
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  helper_method :checkLogin
  helper_method :getLoggedInUser

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = @loggedInUser.created_events.build(event_params)

    respond_to do |format|
      if @event.save

        # UsersGoingToEvent.new(user: @loggedInUser, event: @event).save

        format.html { redirect_to events_path, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /events/goto/:id
  def goToEvent
    if join_event_params.owner != @loggedInUser # just to validate user input even more
      if UsersGoingToEvent.where(user: @loggedInUser, event: join_event_params).exists?
        UsersGoingToEvent.where(user: @loggedInUser, event: join_event_params).first.destroy
      else
        UsersGoingToEvent.new(user: @loggedInUser, event: join_event_params).save
      end
    end

    redirect_to users_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:title, :description, :when)
    end

    def join_event_params
      Event.find(params.require(:eventid))
    end

    def checkLogin
      unless loggedin?
        redirect_to root_path
      end
    end

    def loggedin?
      session.key?(:user_id) && (session[:user_id] != nil)
    end

    def getLoggedInUser
      if loggedin?
        @loggedInUser = User.find(session[:user_id])
      end
    end
end
