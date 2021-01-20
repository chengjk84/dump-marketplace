class Public::CartsController < ApplicationController
  def index
    @carts = current_person.orders.where(status_id: 1)
  end

  def create
    @product = Product.find(params[:product_id])
    @orders = current_person.orders.where(business_id: params[:business_id], status_id: 1)

    if @orders.present?
      @order = @orders.first

      @item = @order.items.find_by_product_id(params[:product_id])

      if @item.present?
        @item.update_attribute(:quantity, (@item.quantity + 1))

        @item.total_price = @item.unit_price * @item.quantity
        @item.total_ship = @item.unit_ship * @item.quantity

        if @item.save
          redirect_to :back, notice: '<span class="text-semibold">Well done!</span> Cart item quantity updated.'
        else
          redirect_to :back, alert: '<span class="text-semibold">Oh Snap!</span> Fail to update item quantity.'
        end

      else
        if current_person.state.present?
          @item = @order.items.build
          @item.product_id = @product.id
          @item.unit_price = @product.price

          if current_person.state == "Sabah" || current_person.state == "Labuan"
            @item.unit_ship = @product.shipment_sabah_and_labuan
          elsif current_person.state == "Sarawak"
            @item.unit_ship = @product.shipment_sarawak
          else
            @item.unit_ship = @product.shipment_peninsular
          end

          @item.quantity = 1

          @item.total_price = @item.unit_price * @item.quantity
          @item.total_ship = @item.unit_ship * @item.quantity

          if @item.save
            redirect_to :back, notice: '<span class="text-semibold">Well done!</span> Cart item added.'
          else
            redirect_to :back, alert: '<span class="text-semibold">Oh Snap!</span> Fail to add item.'
          end

        else
          redirect_to edit_person_url(current_person), alert: '<span class="text-semibold">Oh Snap!</span> Please update your address to use shopping cart.'
        end

      end

      #redirect_to :back, notice: '<span class="text-semibold">Well done!</span> Product was added to cart.'
    else
      @order = current_person.orders.build
      @order.business_id = params[:business_id]
      @order.status_id = 1

      if @order.save
        @item = @order.items.find_by_product_id(params[:product_id])

        if @item.present?
          @item.update_attribute(:quantity, (@item.quantity + 1))

          @item.total_price = @item.unit_price * @item.quantity
          @item.total_ship = @item.unit_ship * @item.quantity

          if @item.save
            redirect_to :back, notice: '<span class="text-semibold">Well done!</span> Cart item quantity updated.'
          else
            redirect_to :back, alert: '<span class="text-semibold">Oh Snap!</span> Fail to update item quantity.'
          end

        else

          if current_person.state.present?
            @item = @order.items.build
            @item.product_id = @product.id
            @item.unit_price = @product.price

            if current_person.state == "Sabah" || current_person.state == "Labuan"
              @item.unit_ship = @product.shipment_sabah_and_labuan
            elsif current_person.state == "Sarawak"
              @item.unit_ship = @product.shipment_sarawak
            else
              @item.unit_ship = @product.shipment_peninsular
            end

            @item.quantity = 1

            @item.total_price = @item.unit_price * @item.quantity
            @item.total_ship = @item.unit_ship * @item.quantity

            if @item.save
              redirect_to :back, notice: '<span class="text-semibold">Well done!</span> Cart item added.'
            else
              redirect_to :back, alert: '<span class="text-semibold">Oh Snap!</span> Fail to add item.'
            end

          else
            redirect_to edit_person_url(current_person), alert: '<span class="text-semibold">Oh Snap!</span> Please update your address to use shopping cart.'
          end

        end
      else
        #puts @order.errors.full_messages
        redirect_to :back, alert: '<span class="text-semibold">Oh Snap!</span> Failed to create cart.'
      end
    end
  end


  def update
    @cart = Order.find(params[:id])
    @cart.update_attributes(status_id: 9)
    redirect_to :back, notice: '<span class="text-semibold">Well done!</span>The cart has been canceled.'
  end
end
