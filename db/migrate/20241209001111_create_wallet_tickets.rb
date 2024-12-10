class CreateWalletTickets < ActiveRecord::Migration[8.0]
  def change
    create_table :wallet_tickets do |t|
      t.bigint :wallet_id
      t.bigint :ticket_id
      t.decimal :average_price, precision: 10, scale: 2

      t.timestamps
    end
  end
end
