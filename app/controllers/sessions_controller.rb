class SessionsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
  end

  def create
    if params[:session].present?
      @user = User.find_by_email(params[:session][:email].downcase)
      if @user && @user.authenticate(params[:session][:password])
      else
        flash.now[:message] = 'Invalid email/password combination'
        render 'new'
        return
      end
    else
      flash.now[:message] = 'No session data provided'
      render 'new'
      return
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
end
