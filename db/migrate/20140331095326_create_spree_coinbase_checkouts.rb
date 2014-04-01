class CreateSpreeCoinbaseCheckouts < ActiveRecord::Migration
  def change
    create_table :spree_coinbase_checkouts do |t|
      t.string :coinbase_id
      t.string :status
      t.integer :btc_cents
      t.string :receive_address

      t.timestamps
    end
  end
end
