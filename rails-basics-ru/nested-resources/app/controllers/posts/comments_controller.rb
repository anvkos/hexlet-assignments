class Posts::CommentsController < Posts::ApplicationController
  before_action :set_comment, only: %i[edit update destroy]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comments_params)

    redirect_to post_path(@comment.post), notice: 'Comment was succsessfully created' if @comment.save
  end

  def edit; end

  def update
    if @comment.update(comments_params)
      redirect_to post_path(@comment.post), notice: 'Comment was successfully updated'
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy

    redirect_to post_path(@comment.post), notice: 'Comment was successfully deleted'
  end

  private

  def comments_params
    params.require(:post_comment).permit(:body)
  end

  def set_comment
    @comment = PostComment.find(params[:id])
  end
end
