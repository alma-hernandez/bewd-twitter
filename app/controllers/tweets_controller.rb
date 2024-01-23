class TweetsController < ApplicationController
  before_action :authenticate_user, only: [:create, :destroy]

  def create
    tweet_params = params.require(:tweet).permit(:message)

    current_user = User.find_by(session_token: cookies[:twitter_session_token])

    tweet = current_user.tweets.build(tweet_params)

    if tweet.save
      render json: { message: "Tweet created successfully" }
    else
      render json: { error: tweet.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end

  def destroy
    tweet = Tweet.find_by(id: params[:id])

    current_user = User.find_by(session_token: cookies[:twitter_session_token])

    if tweet && tweet.user == current_user
      tweet.destroy
      render json: { message: "Tweet deleted successfully" }
    else
      render json: { error: "Tweet not found or you don't have permission to delete" }, status: :not_found
    end
  end

    tweets = Tweet.all
    render json: tweets
  end

  def index_by_user
    user = User.find_by(username: params[:username])

    if user
      tweets = user.tweets
      render json: tweets
    else
      render json: { error: "User not found" }, status: :not_found
  end

  private

  def authenticate_user
    unless current_user
      render json: { error: "Not authenticated" }, status: :unauthorized
    end
  end

  def current_user
    @current_user ||= User.find_by(session_token: cookies[:twitter_session_token])
  end
end

  