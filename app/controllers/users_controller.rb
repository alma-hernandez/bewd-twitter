class UsersController < ApplicationController
  def create
    user_params = params.require(:user).permit(:username, :email, :password)

    @user = User.new(user_params)

    if @user.save
      render 'create', status: :created
    else
      render json: { error: @user.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :username)
  end
end
