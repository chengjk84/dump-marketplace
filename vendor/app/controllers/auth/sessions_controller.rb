class Auth::SessionsController < ApplicationController
  def new
  end

  def create
    @person = Person.find_by_email(params[:email])

    if @person && @person.authenticate(params[:password])

      if params[:remember]
        cookies.permanent[:uuid] = @person.uuid
      else
        cookies[:uuid] = @person.uuid
      end

      redirect_to root_url, :notice => "Logged in!"

    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    cookies.delete(:uuid)
    redirect_to root_url, :notice => "Logged out!"
  end
end
