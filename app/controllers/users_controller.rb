class UsersController < ApplicationController
  def index
    if user_signed_in?
      @users = User.visible.by_filter(params, current_user)
        .with_friendship_status_for(current_user)
    else
      @users = User.all
    end
  end

  # HACK: NO BREAKS
  def friend
    @user = User.find(params[:id])
    authorize @user
    if Friendship.where(sender: current_user,
        receiver: @user).count != 0
      redirect_to action: :index
    else
      Friendship.create(sender: current_user,
                        receiver: @user)
      redirect_to action: :index
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
    authorize @user
    @cancers = Cancer.all
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update(user_params)
      redirect_to 'index'
    else
      render 'edit', errors: @user.errors
    end
  end

  def user_params
    params.require(:user)
      .permit(diagnosis_attributes: diagnosis_params)
  end

  def diagnosis_params
    [:stage, :cancer_id]
  end
end
