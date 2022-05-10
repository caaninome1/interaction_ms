class UsersMatchesController < ApplicationController
  before_action :set_users_match, only: %i[ show update destroy ]

  # GET /users_matches
  def index
    @users_matches = UsersMatch.all

    render json: @users_matches
  end

  # GET /users_matches/1
  def show
    render json: @users_match
  end

  # POST /users_matches
  def create
    @users_match = UsersMatch.new(users_match_params)    

    if @users_match.save
      render json: @users_match, status: :created, location: @users_match
    else
      render json: @users_match.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users_matches/1
  def update
    if @users_match.update(users_match_params)
      render json: @users_match
    else
      render json: @users_match.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users_matches/1
  def destroy
    @users_match.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_users_match
      @users_match = UsersMatch.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def users_match_params
      params.require(:users_match).permit(:user_id, :liked_user_id, :date)
    end
end
