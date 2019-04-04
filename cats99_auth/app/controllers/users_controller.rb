class UsersController < ApplicationController
  before_action :require_current_user!, except: [:create, :new]
  def index
    @users = User.all
    render :index
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    #@user.password = [p]
    if @user.save
      login!(@user)
      redirect_to root_url #user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  # def destroy
  #   @user = User.find(params[:id])
  #   @user.destroy 
  # end

  private

  def user_params
    params.require(:user).permit(:user_name, :password)
  end

end

# {
#   user: {
#     username: 'vlad',
#     password: '123456',
#   }
# }