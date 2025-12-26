class UserMailer < ApplicationMailer
  def reset_password
    @user = params[:user]
    @reset_password_url = "#{ENV["FRONTEND_URL"]}/reset-password?token=#{@user.generate_token_for(:password_reset)}"
    mail(to: @user.email, subject: 'Reset Password')
  end

  def verify_email
    @user = params[:user]
    @verify_url = "#{ENV["FRONTEND_URL"]}/verify-email?token=#{@user.generate_token_for(:email_verify)}"
    mail(to: @user.email, subject: 'Verify Your Account')
  end
end
