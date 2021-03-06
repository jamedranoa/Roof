class UsersController < ApplicationController

  before_action :require_signed_out!, :only => [:create, :new]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if user_params[:password] != params[:confirm]
      flash[:errors] = ["Passwords must match"]
      redirect_to root_url
      return @user
    end

    if @user.save
      sign_in(@user)
      redirect_to user_url(@user)
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to root_url
    end
  end

  def show
    if params.include?(:id)
      @user = User.find(params[:id])
      @reviews= Kaminari.paginate_array(@user.reviews.reverse).page(params[:page]).per(5)
    else
      redirect_to user_url(current_user)
    end
  end

  def index
    @users = User.all
  end

  def edit
    @user = current_user
  end


  def update
    @user = current_user
    if @user.update(user_params)
      render :show
    else
      flash.now[:errors] = @user.errors.full_messages
      render :edit
    end
  end

  def trips
    @requests = current_user.made_requests
  end


  private

  def user_params
    params.require(:user).permit(:email, :fname, :password, :lname,:education,:job, :picture, :sex, :intro)
  end

end
