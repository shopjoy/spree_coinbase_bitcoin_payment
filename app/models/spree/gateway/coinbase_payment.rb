module Spree
  class Gateway::CoinbasePayment < Gateway
    preference :api_key, :string
    preference :api_secret, :string

    def supports?(source)
      true
    end

    def provider_class
      ::Coinbase::Client
    end

    def provider
      provider_class.new(preferred_api_key, preferred_api_secret)
    end

    def auto_capture?
      true
    end

    def purchase(amount, coinbase_checkout, gateway_options={})
      # Do nothing because all processing has been done by controller.
      # This method has to exist because auto_capture? is true.

      Class.new do
        def success?; true; end
        def authorization; nil; end
      end.new
    end

    def method_type
      'coinbase'
    end

  end
end
