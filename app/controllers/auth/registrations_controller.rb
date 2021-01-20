class Auth::RegistrationsController < ApplicationController

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(person_params)

    if cookies[:sponsor_token].present?
      sponsor = Person.find_by_sponsor_token(cookies[:sponsor_token])
      @person.sponsor_id = sponsor.id
    else
      @person.sponsor_id = 1
    end

    if @person.save
      redirect_to login_path, notice: 'Sign up successfull.'
    else
      render :new
    end
  end

  private
    def person_params
      params.require(:person).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end

end
