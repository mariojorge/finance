class Ticket < ApplicationRecord
  has_many :wallet_tickets

  validates :name, presence: true

  enum :ticket_class, { acao: 1, fundo_imobiliario: 2, etf: 3, fiagro: 4, fiinfra: 5, small_caps: 6, blue_chip: 7, mid_caps: 8 }
end
