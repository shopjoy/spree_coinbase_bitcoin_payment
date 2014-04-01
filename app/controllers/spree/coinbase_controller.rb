require 'coinbase'

module Spree
  class CoinbaseController < StoreController
    protect_from_forgery :except => :callback

    def page
      order = current_order || raise(ActiveRecord::RecordNotFound)

      begin
        button_name = Spree.t("button.name", :scope => :coinbase, :site_name => Spree::Config.site_name, :order_number => order.number)
        coinbase_options = {
          :button => {
            :callback_url => coinbase_callback_url,
            :success_url => coinbase_success_url,
            :cancel_url => checkout_state_url(order.state)
          }
        }

        response = coinbase.create_button(button_name, order.display_total.money, nil, order.number, coinbase_options)
        redirect_to "http://coinbase.com/checkouts/#{response.button.code}"
      rescue => e
        Rails.logger.error e
        # Redirect back to checkout so buyer can choose alternative payment method
        redirect_to checkout_state_path(order.state)
      end
    end

    def success
      flash.notice = Spree.t(:order_processed_successfully)
      flash[:commerce_tracking] = "nothing special"
      redirect_to order_path(params[:order][:custom], :coinbase_id => params[:order][:id])
    end

    def callback
      order_number = params[:order][:custom]
      order = Order.find_by(:number => order_number)

      raise "Callback rejected: unrecognized order" unless order

      case params[:order][:status]
      when "completed"
        callback_success(order)
      end
      # TODO: handle mispaid amount

      render :text => ""
    end

    private

    def payment_method
      @payment_method ||= Spree::PaymentMethod.find_by(:type => "Spree::Gateway::CoinbasePayment")
    end

    def coinbase
      payment_method.provider
    end

    def callback_success(order)
      order.payments.create!({
        :source => Spree::CoinbaseCheckout.create({
          :coinbase_id => params[:order][:id],
          :status => params[:order][:status],
          :btc_cents => params[:order][:total_btc][:cents],
          :receive_address => params[:order][:receive_address]
        }),
        :amount => order.total,
        :payment_method => payment_method
      })
      order.next
    end
  end
end
