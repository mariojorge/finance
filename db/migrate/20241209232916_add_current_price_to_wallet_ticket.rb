class AddCurrentPriceToWalletTicket < ActiveRecord::Migration[8.0]
  def change
    add_column :wallet_tickets, :current_price, :decimal, precision: 18, scale: 2
  end
end
