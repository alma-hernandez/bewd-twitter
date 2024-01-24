class SessionsController < ApplicationController
  def create
    user_params = params.require(:user).permit(:username, :password)
    user = User.find_by(username: user_params[:username])

    if user && BCrypt::Password.new(user.password) == user_params[:password]
      session = user.sessions.create
      cookies.signed[:twitter_session_token] = session.token

      render json: { success: true }
    else
      render json: { error: 'Invalid username or password' }, status: :unauthorized
    end
  end

  def authenticated
    if current_user
      render json: { authenticated: true, username: current_user.username }
    else
      render json: { authenticated: false }, status: :unauthorized
    end
  end

  def destroy
    if current_user
      session = Session.find_by(token: cookies.signed[:twitter_session_token])
      session.destroy
      cookies.delete(:twitter_session_token)

      render json: { message: 'Logout successful' }
    else
      render json: { error: 'Not authenticated' }, status: :unauthorized
    end
  end

  private

  def current_user
    session = Session.find_by(token: cookies.signed[:twitter_session_token])
    return session.user if session
  end
end
