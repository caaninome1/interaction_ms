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
    @like = Like.where(user_id: @users_match.liked_user_id, liked_user_id: @users_match.user_id).first
    @like.like_status = false
    @like.save
    @like1 = Like.where(user_id: @users_match.user_id, liked_user_id: @users_match.liked_user_id).first
    @like1.like_status = false
    @like1.save
    @users_match.destroy
    render json: @users_match
  end

  # GET /users_matches/user/:user_id
  def user_likes
    @match = UsersMatch.where("user_id = :user_id OR liked_user_id = :user_id", {user_id: params[:user_id]})
    render json: @match
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
