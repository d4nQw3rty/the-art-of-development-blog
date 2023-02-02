class CommentsController < ApplicationController
  load_and_authorize_resource except: :create

  def create
    @comment = Comment.new(comments_params)
    @current_user = current_user
    @comment.author = @current_user

    if @comment.save
      redirect_to user_post_path(id: params.require(:post_id), author_id: params.require(:user_id))
    else
      render 'new'
    end
  end

  def destroy
    @current_user = current_user
    @comment = Comment.find(params[:id])  
    @comment.post.update(comments_counter: @comment.post.comments_counter - 1)
    @comment.destroy
    redirect_to user_path(current_user)  
  end  

  private

  def comments_params
    params.require(:comment).permit(:text, :post_id)
  end
end
