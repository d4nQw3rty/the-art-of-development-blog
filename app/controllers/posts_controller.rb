class PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @current_user = current_user
    @user = User.includes(:posts, posts: [:comments, { comments: [:author] }]).find(params[:user_id])
  end

  def show
    @post = Post.find(params[:id])
    @current_user = current_user
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user
    if @post.save
      redirect_to user_path(@current_user)
    else
      render :new
    end
  end

  def destroy
    @current_user = current_user
    @post = Post.find(params[:id])
    @post.author.update(posts_counter: @post.author.posts_counter - 1)
    @post.destroy
    redirect_to user_path(current_user)
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
