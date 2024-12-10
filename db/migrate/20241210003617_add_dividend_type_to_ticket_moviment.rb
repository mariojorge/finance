class AddDividendTypeToTicketMoviment < ActiveRecord::Migration[8.0]
  def change
    add_column :ticket_moviments, :dividend_type, :integer
  end
end
