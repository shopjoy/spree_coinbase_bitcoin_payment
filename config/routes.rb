Spree::Core::Engine.routes.draw do
  # Add your extension routes here
  get "coinbase" => "coinbase#page", :as => :coinbase_page
  get "coinbase/success" => "coinbase#success", :as => :coinbase_success
  post "coinbase/callback" => "coinbase#callback", :as => :coinbase_callback
end
