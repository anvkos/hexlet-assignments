# frozen_string_literal: true

class VacanciesController < ApplicationController
  before_action :set_vacancy, only: %i[publish archive]

  def index
    @on_moderate = Vacancy.on_moderate
    @published = Vacancy.published
  end

  def new
    @vacancy = Vacancy.new
  end

  def create
    @vacancy = Vacancy.new(vacancy_params)

    if @vacancy.save
      redirect_to vacancies_path, notice: 'Vacancy was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # BEGIN
  def publish
    @vacancy.publish
    if @vacancy.save
      redirect_to vacancies_path, notice: 'Vacancy was successfully published'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def archive
    @vacancy.archive
    if @vacancy.save
      redirect_to vacancies_path, notice: 'Vacancy was successfully archived'
    else
      render :new, status: :unprocessable_entity
    end
  end
  # END

  private

  def vacancy_params
    params.require(:vacancy).permit(:title, :description)
  end

  def set_vacancy
    @vacancy = Vacancy.find(params[:id])
  end
end
