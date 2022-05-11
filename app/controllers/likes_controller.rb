class LikesController < ApplicationController
  before_action :set_like, only: %i[ show update destroy ]

  # GET /likes
  def index
    @likes = Like.all
    render json: @likes
  end

  # GET /likes/:id
  def show
    @like = Like.find(params[:id])
    render json: @like
  end

  # POST /likes
  def create
    @like = Like.new(like_params)

    if @like.save
      render json: @like, status: :created, location: @like
    else
      render json: @like.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /likes/1
  def update
    if @like.update(like_params)
      render json: @like
    else
      render json: @like.errors, status: :unprocessable_entity
    end
  end

  # DELETE /likes/1
  def destroy
    @like.destroy
  end

  # GET /likes/user/:user_id
  def user_likes
    @likes = Like.where(user_id: params[:user_id])
    render json: @likes
  end

  # GET /likes/user_liked/:user_id
  def user_liked_likes
    @likes = Like.where(liked_user_id: params[:user_id])
    render json: @likes
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_like
      @like = Like.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def like_params
      params.require(:like).permit(:user_id, :liked_user_id, :like_status)
    end
end
