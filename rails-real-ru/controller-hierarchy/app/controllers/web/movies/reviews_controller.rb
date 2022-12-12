# frozen_string_literal: true

class Web::Movies::ReviewsController < Web::Movies::ApplicationController
  before_action :set_review, only: %i[edit update destroy]

  def index
    @reviews = resource_movie.reviews
  end

  def new
    @review = resource_movie.reviews.new
  end

  def create
    @review = resource_movie.reviews.build(review_params)

    if @review.save
      redirect_to movie_reviews_path(@review.movie), notice: t('success')
    else
      render :new, notice: t('fail')
    end
  end

  def edit;end

  def update
    if @review.update(review_params)
      redirect_to movie_reviews_path(@review.movie), notice: t('success')
    else
      render :edit, notice: t('fail')
    end
  end

  def destroy
    if @review.destroy
      redirect_to movie_reviews_path(@review.movie), notice: t('success')
    else
      redirect_to movie_reviews_path(@review.movie), notice: t('fail')
    end
  end

  private

  def review_params
    params.require(:review).permit(:body)
  end

  def set_review
    @review = resource_movie.reviews.find(params[:id])
  end
end
