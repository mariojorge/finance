class AddOthersToWalletTicket < ActiveRecord::Migration[8.0]
  def change
    add_column :wallet_tickets, :total, :decimal, precision: 18, scale: 2
    add_column :wallet_tickets, :total_invested, :decimal, precision: 18, scale: 2
    add_column :wallet_tickets, :stock_equity, :decimal, precision: 18, scale: 2
    add_column :wallet_tickets, :profit, :decimal, precision: 18, scale: 2
    add_column :wallet_tickets, :profit_percent, :decimal, precision: 18, scale: 2
    add_column :wallet_tickets, :dividends, :decimal, precision: 18, scale: 2
    add_column :wallet_tickets, :final_profit, :decimal, precision: 18, scale: 2
    add_column :wallet_tickets, :final_profit_percent, :decimal, precision: 18, scale: 2
    add_column :wallet_tickets, :current_variation, :decimal, precision: 10, scale: 2
  end
end
