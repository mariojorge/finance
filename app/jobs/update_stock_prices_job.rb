require 'net/http'
require 'json'

class UpdateStockPricesJob < ApplicationJob
  queue_as :default

  API_URL = 'https://brapi.dev/api/quote/list'.freeze
  API_TOKEN = 'bDF4U5u6oDN5Ysp4K6bCcg'.freeze # Substitua pelo seu token de autenticação

  def perform
    # Buscar os tickets com quantidade atual maior que zero
    wallet_tickets = WalletTicket.joins(:ticket).select { |i| i.quantity > 0}

    return if wallet_tickets.empty?

    wallet_tickets.each do |wallet_ticket|
      uri = URI("#{API_URL}?search=#{wallet_ticket.ticket.name}&token=#{API_TOKEN}")

      response = Net::HTTP.get(uri)
      data = JSON.parse(response)

      if data["stocks"].present?
        puts "Importando dados de cotação para #{wallet_ticket.ticket.name}"
        current_price = data["stocks"][0]["close"]

        if current_price.present?
          wallet_ticket.update_column(:current_price, current_price)
        end
      end
    end
  rescue StandardError => e
    Rails.logger.error("Erro ao executar UpdateStockPricesJob: #{e.message}")
  end
end
