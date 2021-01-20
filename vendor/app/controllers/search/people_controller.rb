class Search::PeopleController < ApplicationController
  def index
    if params[:state].present?
      @people = Person.active_person.where(state: params[:state]).order("updated_at DESC").paginate(page: params[:page], per_page: 12)
    elsif params[:search].present?
      @people = Person.active_person.where(['first_name LIKE ?', "%#{params[:search]}%"]).order("updated_at DESC").paginate(page: params[:page], per_page: 12)
    else
      @people = Person.active_person.order("updated_at DESC").paginate(page: params[:page], per_page: 12)
    end
  end
end
