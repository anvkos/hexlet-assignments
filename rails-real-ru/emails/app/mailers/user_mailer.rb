# frozen_string_literal: true

class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def account_activation
    # BEGIN
    @user = User.find_by(email: params[:user].email)

    params = {
      :confirmation_token => @user.confirmation_token,
    }
    @url = "#{confirm_user_url}?#{params.to_query}"

    mail(to: @user.email, subject: 'Complete registration')
    # END
  end
end
