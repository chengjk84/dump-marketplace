class Api::BaseController < JSONAPI::ResourceController

  def index
    render json: Product.all
  end
end
