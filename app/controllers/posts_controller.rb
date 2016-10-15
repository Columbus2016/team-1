class PostsController < ApplicationController
  before_action :load_post, except: [:new, :index, :create]
  def new
  end

  def create
    @post = Post.new(post_attributes)
    if @post.save
      redirect_to @post
    else
      render 'new', errors: @post.errors
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit', errors: @post.errors
    end
  end

  protected
  def load_post
    @post = Post.find(params[:id])
    authorize @post
  end

  def post_attributes
    params.require(:post)
      .permit(:body)
      .merge(user_id: current_user.id)
  end
end
