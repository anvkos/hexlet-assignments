# frozen_string_literal: true

require 'csv'
require 'benchmark'

class Web::UsersController < Web::ApplicationController
  # BEGIN
  include ActionController::Live
  # END

  def index
    @users = User.page(params[:page])
  end

  def show
    @user = User.find params[:id]
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find params[:id]
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user, notice: t('success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @user = User.find params[:id]

    if @user.update(user_params)
      redirect_to @user, notice: t('success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find params[:id]

    @user.destroy

    redirect_to users_url, notice: t('success')
  end

  # 15.750805168000625 sec
  def normal_csv
    response_time = Benchmark.realtime do
      respond_to do |format|
        format.csv do
          csv = generate_csv(User.column_names, User.all)
          send_data(csv)
        end
      end
    end
    logger.info "#{'-' * 20} #{__method__}: #{response_time} #{'-' * 20}"
  end

  # BEGIN
  # stream_csv: 36.00037484800032 sec
  def stream_csv
    response_time = Benchmark.realtime do
      respond_to do |format|
        format.csv do
          last_modifiled_time = User.order(updated_at: :asc).pluck(:updated_at).first
          csv_headers(filename: 'report.csv', last_modifiled_time: last_modifiled_time)

          column_names = User.column_names
          response.stream.write CSV.generate_line(column_names)
          User.find_each do |user|
            response.stream.write CSV.generate_line(user.attributes.values_at(*column_names))
          end
        ensure
          response.stream.close
        end
      end
    end
    logger.info "#{'-' * 20} #{__method__}: #{response_time} #{'-' * 20}"
  end
  # END

  private

  def csv_headers(options)
    headers.delete('Content-Length')
    headers['Cache-Control'] = 'no-cache'
    headers['Content-Type'] = 'text/csv'
    headers['Content-Disposition'] = "attachment; filename=#{options[:filename]}"
    headers['Last-Modified'] = "#{options[:last_modifiled_time]}"

  end

  def generate_csv(column_names, records)
    CSV.generate do |csv|
      csv << column_names # add headers to the CSV

      records.find_each do |record|
        csv << record.attributes.values_at(*column_names)
      end
    end
  end

  def user_params
    params.require(:user).permit(
      :name,
      :email
    )
  end
end
