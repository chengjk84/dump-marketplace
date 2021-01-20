class Public::OrdersController < ApplicationController
  def index
    if params[:search].present?
      @orders = current_person.orders.where(id: params[:search]).order("updated_at DESC").paginate(page: params[:page], per_page: 12)
    else
      @orders = current_person.orders.all_except([1, 9]).order("updated_at DESC").paginate(page: params[:page], per_page: 12)
    end
  end

  def show
    @order = current_person.orders.find(params[:id])
    @person = current_person
    @business = @order.business
  end

  def update
    @order = current_person.orders.find(params[:id])

    # unpaid
    if params[:status].to_i == 2
      @order.update_attributes( status_id: params[:status], ordered_at: DateTime.now, subtotal: @order.get_subtotal, shipment:@order.get_shipment, total: @order.get_total )
      redirect_to person_order_path(current_person, @order), notice: '<span class="text-semibold">Well done!</span> Order has been placed, please proceed to payment or else.'

    # request new total
    elsif params[:status].to_i == 3
      @order.update_attributes( status_id: params[:status] )
      redirect_to person_order_path(current_person, @order), notice: '<span class="text-semibold">Well done!</span> Request for combined shipment has been issued.'

    # paid
    elsif params[:status].to_i == 5
      if current_person.cash_wallet.success > @order.total

        Transaction.create!(
          wallet_id: current_person.cash_wallet.id,
          ref_no: "orde_#{@order.id}_",
          description: "Payment to #{@order.business.name} for Order ##{@order.id}",
          credit: @order.total,
          status: "pending" )

        Statement.create!(
          bank_id: @order.business.bank.id,
          description: "Payment from #{current_person.full_name} for Order ##{@order.id}",
          ref_no: "orde_#{@order.id}_",
          debit: @order.total,
          status: "pending" )

        @order.update_attributes( status_id: params[:status], paid_at: DateTime.now )

        # commission distribution go here...
        commission = 0.00

        if @order.subtotal < 200.00
          commission = @order.subtotal * 0.1060
        elsif @order.subtotal < 300.00
          commission = @order.subtotal * 0.0954
        elsif @order.subtotal < 400.00
          commission = @order.subtotal * 0.0848
        elsif @order.subtotal < 500.00
          commission = @order.subtotal * 0.0742
        elsif @order.subtotal < 600.00
          commission = @order.subtotal * 0.0636
        elsif @order.subtotal < 700.00
          commission = @order.subtotal * 0.0530
        elsif @order.subtotal < 800.00
          commission = @order.subtotal * 0.0424
        elsif @order.subtotal < 900.00
          commission = @order.subtotal * 0.0318
        else
          commission = @order.subtotal * 0.0212
        end

        Transaction.create!(
          wallet_id: current_person.reward_point.id,
          ref_no: "orde_#{@order.id}_owne",
          description: "Commission received from #{current_person.full_name} for Order ##{@order.id}",
          debit: commission * 0.01,
          status: "pending" )

        person = @order.business.referrer

        Transaction.create!(
          wallet_id: person.cash_wallet.id,
          ref_no: "orde_#{@order.id}_refe",
          description: "Commission received from #{@order.business.name} for Order ##{@order.id}",
          debit: commission * 0.01,
          status: "pending" )

        if current_person.sponsor.present?
          @upper_1 = current_person.sponsor
          Transaction.create!( wallet_id: @upper_1.cash_wallet.id, ref_no: "orde_#{@order.id}_comm", description: "Commission received from #{@order.business.name} for Order ##{@order.id}", debit: commission * 0.01, status: "pending" )

          if @upper_1.sponsor.present?
            @upper_2 = @upper_1.sponsor
            if @upper_2.get_membership == "Free"
              Transaction.create!( wallet_id: @upper_2.cash_wallet.id, ref_no: "orde_#{@order.id}_comm", description: "Commission received from #{@order.business.name} for Order ##{@order.id}", debit: commission * 0.01, status: "pending" )

              if @upper_2.sponsor.present?
                @upper_3 = @upper_2.sponsor
                if @upper_3.get_membership == "Free"
                  Transaction.create!( wallet_id: @upper_3.cash_wallet.id, ref_no: "orde_#{@order.id}_comm", description: "Commission received from #{@order.business.name} for Order ##{@order.id}", debit: commission * 0.01, status: "pending" )

                  if @upper_3.sponsor.present?
                    @upper_4 = @upper_3.sponsor
                    if @upper_4.get_membership == "Standard"
                      Transaction.create!( wallet_id: @upper_4.cash_wallet.id, ref_no: "orde_#{@order.id}_comm", description: "Commission received from #{@order.business.name} for Order ##{@order.id}", debit: commission * 0.007, status: "pending" )
                      Transaction.create!( wallet_id: @upper_4.reward_point.id, ref_no: "orde_#{@order.id}_comm", description: "Commission received from #{@order.business.name} for Order ##{@order.id}", debit: commission * 0.003, status: "pending" )

                    if @upper_4.sponsor.present?
                      @upper_5 = @upper_4.sponsor
                      if @upper_5.get_membership == "Premium"
                        Transaction.create!( wallet_id: @upper_5.cash_wallet.id, ref_no: "orde_#{@order.id}_comm", description: "Commission received from #{@order.business.name} for Order ##{@order.id}", debit: commission * 0.007, status: "pending" )
                        Transaction.create!( wallet_id: @upper_5.reward_point.id, ref_no: "orde_#{@order.id}_comm", description: "Commission received from #{@order.business.name} for Order ##{@order.id}", debit: commission * 0.003, status: "pending" )
                      end
                    end
                    end
                  end
                end
              end
            end
          end
        end

        redirect_to person_order_path(current_person, @order), notice: '<span class="text-semibold">Well done!</span> Payment has been made.'
      else
        redirect_to person_order_path(current_person, @order), alert: '<span class="text-semibold">Oh Snap!!</span> Not enough balance, please top-up.'
      end

    # completed
    elsif params[:status].to_i == 7
      ref_no = "orde_#{@order.id}_"

      transactions = Transaction.where(['ref_no LIKE ?', "%#{ref_no}%"])
      transactions.each do |transaction|
        transaction.update_attributes(status: "success")
      end

      statements = Statement.where(['ref_no LIKE ?', "%#{ref_no}%"])
      statements.each do |statement|
        statement.update_attributes(status: "success")
      end

      @order.update_attributes( status_id: params[:status], completed_at: DateTime.now)

      redirect_to person_order_path(current_person, @order), notice: '<span class="text-semibold">Well done!</span> Thank you for shopping with us.'


    # returned
    elsif params[:status].to_i == 8
      @order.update_attributes( status_id: params[:status], returned_at: DateTime.now )
      redirect_to person_order_path(current_person, @order), notice: '<span class="text-semibold">Well done!</span> Request for items returned has been issued.'

    elsif params[:status].to_i == 9
      @order.update_attributes( status_id: params[:status], complain_at: DateTime.now )
      redirect_to person_order_path(current_person, @order), notice: '<span class="text-semibold">Well done!</span> Complain on shipment has been issued.'

    else
      redirect_to :back, alert: '<span class="text-semibold">Oh Snap!</span> Failed on ordering process.'
    end
  end
end
