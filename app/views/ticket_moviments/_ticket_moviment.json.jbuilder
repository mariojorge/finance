json.extract! ticket_moviment, :id, :moviment_type, :moviment_date, :institution, :wallet_ticket_id, :quantity, :price, :com_date, :created_at, :updated_at
json.url ticket_moviment_url(ticket_moviment, format: :json)
