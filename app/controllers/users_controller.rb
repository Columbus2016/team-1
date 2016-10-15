class UsersController < ApplicationController
  def index
    if user_signed_in?
      @users = User.all.by_filter(params, current_user)
    else
      @users = User.all
    end
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    @cancers = Cancer.all
  end

  def create
    puts params.inspect
  end
end
