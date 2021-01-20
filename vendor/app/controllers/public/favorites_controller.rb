class Public::FavoritesController < ApplicationController
  def create
    @favorite = current_person.favorites.find_by_product_id(params[:product_id])

    if @favorite.present?
      redirect_to :back, alert: '<span class="text-semibold">Oh snap!</span> Product already marked as favorite.'
    else
      @favorite = current_person.favorites.build
      @favorite.product_id = params[:product_id]

      if @favorite.save
        redirect_to :back, notice: '<span class="text-semibold">Well done!</span> Product was marked as favorite.'
      else
        redirect_to :back, alert: '<span class="text-semibold">Oh snap!</span> Marked as favorite process fail.'
      end

    end
    #redirect_to :back, notice: '<span class="text-semibold">Well done!</span> Product was added as favorite.'
  end
end
