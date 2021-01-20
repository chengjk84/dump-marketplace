class Public::PeopleController < ApplicationController
  def index
  end

  def show

  end

  def edit
    @person = current_person
  end

  def update
    @person = current_person

    if @person.update(person_params)
      redirect_to edit_person_url(@person), notice: '<span class="text-semibold">Well done!</span> Your profile settings have been saved.'
    else
      render :edit
    end
  end


  private

    def person_params
      params.require(:person).permit(
        :password, :password_confirmation,
        :email, :mobile, :first_name,
        :last_name, :gender_id,
        :identification, :identification_photo,
        :bank_name, :bank_account_no, :bank_account_name,
        :street_1, :street_2, :city, :postcode, :state, :country,
        :avatar
        )
    end
end
