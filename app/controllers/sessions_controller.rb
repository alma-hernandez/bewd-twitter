class SessionsController < ApplicationController
    def create
        user_params = params.require(:user).permit(:username, :password)
        user = User.find_by(username: user_params[:username])
    
        if user && BCrypt::Password.new(user.password_digest) == user_params[:password]
       
          session[:user_id] = user.id
    
          cookies.permanent[:twitter_session_token] = user.session_token
    
          render json: { message: "Session created successfully" }
        else
          render json: { error: "Invalid username or password" }, status: :unauthorized
        end
      end
    
      def authenticated
        if current_user
          render json: { authenticated: true }
        else
          render json: { authenticated: false }, status: :unauthorized
        end
      end
    
      def destroy
        if current_user
         
          current_user.reset_session_token
          session[:user_id] = nil
          cookies.delete(:twitter_session_token)
    
          render json: { message: "Logout successful" }
        else
          render json: { error: "Not authenticated" }, status: :unauthorized
        end
      end
    
      private
    
      def current_user
        @current_user ||= User.find_by(session_token: cookies[:twitter_session_token])
      end
    end