class WalletTicket < ApplicationRecord
  belongs_to :wallet
  belongs_to :ticket
  has_many :ticket_moviments

  validates_presence_of :ticket_id
  validates_uniqueness_of :wallet_id, scope: :ticket_id

  def quantity
    ticket_moviments.where(moviment_type: :compra).sum(:quantity) - ticket_moviments.where(moviment_type: :venda).sum(:quantity)
  end

  def total
    return 0 if quantity == 0
    ticket_moviments.where(moviment_type: :compra).sum(&:total) - ticket_moviments.where(moviment_type: :venda).sum(&:total)
  end

  def average_price
    return 0 if quantity == 0
    total / quantity
  end

  def total_invested
    return 0 if quantity == 0
    quantity * average_price
  end

  def stock_equity
    return 0 if quantity == 0
    quantity * current_price rescue 0
  end

  def profit
    return 0 if quantity == 0
    stock_equity - total_invested
  end

  def profit_percent
    return 0 if quantity == 0
    (profit / total_invested) * 100
  end

  def dividends
    return 0 if quantity == 0
    ticket_moviments.where(moviment_type: :lucro).sum(&:total)
  end

  def final_profit
    return 0 if quantity == 0
    profit + dividends
  end

  def final_profit_percent
    return 0 if quantity == 0
    (final_profit / total_invested) * 100
  end
end
