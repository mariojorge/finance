class TicketMoviment < ApplicationRecord
  belongs_to :wallet_ticket

  validates_presence_of :quantity, :price

  enum :moviment_type, { compra: 1, venda: 2, lucro: 3 }

  enum :dividend_type, { dividendo: 1, rendimento: 2, jcp: 3 }

  def total
    quantity * price
  end

end
