class Admin::PeopleController < Admin::BaseController
  before_action :authenticate_admin!

  def index
    @people = Person.got_identification.where(verified_identification: false).paginate(page: params[:page], per_page: 12).order('updated_at DESC')
  end

  def update
    @person = Person.find(params[:id])
    @person.update_attributes(verified_identification: true)
    redirect_to admin_people_url, notice: '<span class="text-semibold">Well done!</span> Person has been verified.'
  end
end
