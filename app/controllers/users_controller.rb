class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :getLoggedInUser, except: [:login, :newlogin], unless: :loggedin?
  before_action :loggedin?, except: [ :login, :newlogin ]

  helper_method :loggedin?
  helper_method :getLoggedInUser

  # GET /users
  # GET /users.json
  def index

    if loggedin?
      redirect_to events_path
    end

    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        @user.login(session)
        loggedin?
        format.html { redirect_to root_path, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.logout(session)
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /users/login/
  def newlogin
      @user = User.find_by(login_params)
      if @user != nil
        @user.login(session)
        redirect_to root_path
      else
        respond_to do |format|
          format.html { redirect_to root_url, notice: 'Email not found.' }
        end
      end
  end

  def logout
    getLoggedInUser&.logout(session)
    redirect_to root_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :name)
    end

    def login_params
      params.require(:user).permit(:email)
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
