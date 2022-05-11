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
    @users_match = UsersMatch.new()
    us_match = false

    if @like.like_status
      us_likes = @like.all_likes(@like.liked_user_id)
      

      us_likes.each do |x|
        if x.liked_user_id == @like.user_id
          if x.like_status
            us_match = true          
          end
        end
      end    
    end

    if @like.save
      render json: @like, status: :created, location: @like
      
    else
      render json: @like.errors, status: :unprocessable_entity
    end

    if us_match
      @users_match.user_id = @like.liked_user_id
      @users_match.liked_user_id = @like.user_id
      @users_match.save
      @users_match1 = UsersMatch.new()
      @users_match1.user_id = @like.user_id
      @users_match1.liked_user_id = @like.liked_user_id
      @users_match1.save      
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
