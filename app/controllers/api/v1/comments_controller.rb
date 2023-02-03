class Api::V1::CommentsController < Api::V1::ApplicationController
  def index
    @comments = Comment.where(post_id: params[:post_id])

    render json: @comments, only: %i[id text post_id author_id]
  end

  def show
    render json: @commment
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author = User.find(params[:user_id])
    @comment.post = Post.find(params[:post_id])

    if @comment.save
      render json: { status: 'SUCCESS', message: 'Comment was created successfully!', data: @comment }, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:id, :text)
  end
end
