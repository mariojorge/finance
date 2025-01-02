class WalletTicket < ApplicationRecord
  belongs_to :wallet
  belongs_to :ticket
  has_many :ticket_moviments, dependent: :destroy

  attr_default :finished, false

  validates_presence_of :ticket_id
  #validates_uniqueness_of :wallet_id, scope: :ticket_id

  def active?
    !finished
  end

  def consolidate
    if self.quantity > 0
      self.total = ticket_moviments.where(moviment_type: :compra).sum(&:total) - ticket_moviments.where(moviment_type: :venda).sum(&:total)
      self.average_price = total / quantity
      self.total_invested = quantity * average_price
      self.stock_equity = quantity * current_price
      self.profit = stock_equity - total_invested
      self.profit_percent = (profit / total_invested) * 100
      self.dividends = ticket_moviments.where(moviment_type: :lucro).sum(&:total)
      self.final_profit = profit + dividends
      self.final_profit_percent = (final_profit / total_invested) * 100
    else
      self.total = 0
      self.average_price = 0
      self.total_invested = 0
      self.stock_equity = 0
      self.profit = 0
      self.profit_percent = 0
      self.dividends = 0 
      self.final_profit = 0
      self.final_profit_percent = 0
    end
  end

  def quantity
    ticket_moviments.where(moviment_type: :compra).sum(:quantity) - ticket_moviments.where(moviment_type: :venda).sum(:quantity)
  end
end
