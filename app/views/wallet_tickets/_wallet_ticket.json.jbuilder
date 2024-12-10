json.extract! wallet_ticket, :id, :wallet_id, :ticket_id, :average_price, :created_at, :updated_at
json.url wallet_ticket_url(wallet_ticket, format: :json)
