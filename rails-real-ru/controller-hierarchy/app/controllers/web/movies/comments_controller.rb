# frozen_string_literal: true

class Web::Movies::CommentsController < Web::Movies::ApplicationController
  before_action :set_comment, only: %i[edit update destroy]

  def index
    @comments = resource_movie.comments
  end

  def new
    @comment = resource_movie.comments.new
  end

  def create
    @comment = resource_movie.comments.build(comment_params)
    if @comment.save
      redirect_to movie_comments_path(@comment.movie), notice: t('success')
    else
      render :new
    end
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to movie_comments_path(@comment.movie), notice: t('success')
    else
      render :edit, notice: t('fail')
    end
  end

  def destroy
    if @comment.destroy
      redirect_to movie_comments_path(@comment.movie), notice: t('success')
    else
      redirect_to movie_comments_path(@comment.movie), notice: t('fail')
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_comment
    @comment = resource_movie.comments.find(params[:id])
  end
end
