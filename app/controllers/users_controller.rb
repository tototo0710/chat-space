class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.where("name LIKE(?)", "%#{params[:keyword]}%")
    respond_to do |format|
     format.html
     format.json
   end
  end

  def edit
    @user = set_user
  end

  def update
    user = set_user
    user.update(user_params)
    redirect_to root_url
  end

  private
  def user_params
    params.require(:user).permit(:name, :email)
  end
  def set_user
    User.find(params[:id])
  end

end
