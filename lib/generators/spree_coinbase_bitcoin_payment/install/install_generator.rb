module SpreeCoinbaseBitcoinPayment
  module Generators
    class InstallGenerator < Rails::Generators::Base

      class_option :auto_run_migrations, :type => :boolean, :default => false

      def add_javascripts
        frontend_js_file = "vendor/assets/javascripts/spree/frontend/all.js"
        backend_js_file = "vendor/assets/javascripts/spree/backend/all.js"

        if File.exist?(backend_js_file) && File.exist?(frontend_js_file)
          append_file frontend_js_file, "//= require spree/frontend/spree_coinbase_bitcoin_payment\n"
          append_file frontend_css_file, "//= require spree/backend/spree_coinbase_bitcoin_payment\n"
        end
      end

      def add_stylesheets
        frontend_css_file = "vendor/assets/stylesheets/spree/frontend/all.css"
        backend_css_file = "vendor/assets/stylesheets/spree/backend/all.css"

        if File.exist?(backend_css_file) && File.exist?(frontend_css_file)
          inject_into_file frontend_css_file, " *= require spree/frontend/spree_coinbase_bitcoin_payment\n", :before => /\*\//, :verbose => true
          inject_into_file backend_css_file, " *= require spree/backend/spree_coinbase_bitcoin_payment\n", :before => /\*\//, :verbose => true
        end
      end

      def add_migrations
        run 'bundle exec rake railties:install:migrations FROM=spree_coinbase_bitcoin_payment'
      end

      def run_migrations
        run_migrations = options[:auto_run_migrations] || ['', 'y', 'Y'].include?(ask 'Would you like to run the migrations now? [Y/n]')
        if run_migrations
          run 'bundle exec rake db:migrate'
        else
          puts 'Skipping rake db:migrate, don\'t forget to run it!'
        end
      end
    end
  end
end
