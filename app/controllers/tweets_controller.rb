class TweetsController < ApplicationController
  def create
    tweet_params = params.require(:tweet).permit(:message)

    return render json: { success: false } if current_user.nil?

    tweet = current_user.tweets.new(tweet_params)

    if tweet.save!
      render json: { tweet: { username: tweet.user.username, message: tweet.message } }
    else
      render json: { errors: tweet.errors.full_messages }, status: :unprocessable_entity
    end
  end
 

  def destroy
    tweet = Tweet.find_by(id: params[:id])

    if tweet && tweet.user == current_user
      tweet.destroy
      render json: { success: true }
    else
      render json: { success: false }, status: :not_found
    end
  end

  def index
    @tweets = Tweet.all
    render json: { tweets: @tweets.map {|tweet| { id: tweet.id, username: tweet.user.username, message: tweet.message}}}
  end

  def index_by_user
    user = User.find_by(username: params[:username])

    if user
      @tweets = user.tweets
      render json: {
        tweets: @tweets.map { |tweet| { id: tweet.id, username: user.username, message: tweet.message } }
      }
    else
      render json: { error: 'Test Message' }, status: :not_found
    end
  end

    if user
      @tweets = user.tweets
      render 'tweets/index'
    else
      render json: { error: 'User not found' }, status: :not_found
    end
  end

  private

  def current_user
    session = Session.find_by(token: cookies.signed[:twitter_session_token])
    session.user if session
  end
end
