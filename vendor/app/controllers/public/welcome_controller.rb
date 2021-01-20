class Public::WelcomeController < ApplicationController
  def index
    @random_businesses = Business.all.sample(9)

    @random_products = Product.active_products.sample(8)
    @latest_products = Product.active_products.last(16).reverse
  end
end
