class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    confirm_user = User.find_by(email: @user.email)
    if confirm_user
      redirect_to new_user_path, notice: "そのemailは既に登録されています。"
    else
      @user.save
      redirect_to new_session_path
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end