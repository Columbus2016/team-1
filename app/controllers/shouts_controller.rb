class ShoutsController < ApplicationController
  before_action :load_shout, except: [:new, :index, :create]

  def index
    if user_signed_in?
      @shouts = Shout.joins(:user)
        .where(user: User.by_filter(params, current_user))
    else
      @shouts = Shout.all
    end
  end

  def new
  end

  def create
    @shout = Shout.new(shout_attributes)
    if @shout.save
      redirect_to 'index'
    else
      render 'new', errors: @shout.errors
    end
  end

  def edit
  end

  def update
    if @shout.update(shout_attributes)
      redirect_to 'index'
    else
      render 'edit', errors: @shout.errors
    end
  end

  protected
  def load_shout
    @shout = Shout.find(params[:id])
    authorize @shout
  end

  def shout_attributes
    params.require(:shout)
      .permit(:body)
      .merge(user_id: current_user.id)
  end
end
