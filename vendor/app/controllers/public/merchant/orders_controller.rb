class Public::Merchant::OrdersController < ApplicationController
  def index
    @business = Business.find(params[:business_id])

    if params[:search].present?
      @orders = @business.orders.where(id: params[:search]).order("updated_at DESC").paginate(page: params[:page], per_page: 12)
    else
      @orders = @business.orders.all_except([1, 2, 10]).order("updated_at DESC").paginate(page: params[:page], per_page: 12)
    end
  end

  def show
    @business = Business.find(params[:business_id])
    @order = @business.orders.find(params[:id])
    @person = @order.person
  end

  def edit
    @business = Business.find(params[:business_id])
    @order = @business.orders.find(params[:id])
  end

  def update
    @business = Business.find(params[:business_id])
    @order = @business.orders.find(params[:id])

    if params[:status].present?
      ref_no = "orde_#{@order.id}_"

      transactions = Transaction.where(['ref_no LIKE ?', "%#{ref_no}%"])
      transactions.each do |transaction|
        transaction.update_attributes(status: "success")
      end

      statements = Statement.where(['ref_no LIKE ?', "%#{ref_no}%"])
      statements.each do |statement|
        statement.update_attributes(status: "success")
      end

      @order.update_attributes( status_id: params[:status])

      redirect_to business_merchant_order_url(@business, @order), notice: '<span class="text-semibold">Well done!</span> Thank you for selling with us.'
    else
      if @order.update(order_params)
        redirect_to business_merchant_order_url(@business, @order), notice: '<span class="text-semibold">Well done!</span> Shipment fees have been updated.'
      else
        render :edit
      end
    end
  end

  def destroy
    @business = Business.find(params[:business_id])
    @order = @business.orders.find(params[:id])

    ref_no = "orde_#{@order.id}_"

    transactions = Transaction.where(['ref_no LIKE ?', "%#{ref_no}%"])
    transactions.each do |transaction|
      transaction.update_attributes(status: "cancel")
    end

    statements = Statement.where(['ref_no LIKE ?', "%#{ref_no}%"])
    statements.each do |statement|
      statement.update_attributes(status: "cancel")
    end

    @order.update_attributes( status_id: params[:status])

    redirect_to business_merchant_order_url(@business, @order), notice: '<span class="text-semibold">Well done!</span> Order has been canceled.'
  end

  private

    def order_params
      params.require(:order).permit( :shipment, :status_id, :shipment_service, :shipment_tracking_no, :shipment_checking_url)
    end
end
