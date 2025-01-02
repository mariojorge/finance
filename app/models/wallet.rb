class Wallet < ApplicationRecord
  has_many :wallet_tickets, dependent: :destroy

  def invested_total
    wallet_tickets.sum(:total_invested)
  end

  def stock_equity_total
    wallet_tickets.sum(:stock_equity)
  end
end
