class CreateTicketMoviments < ActiveRecord::Migration[8.0]
  def change
    create_table :ticket_moviments do |t|
      t.integer :moviment_type
      t.date :moviment_date
      t.string :institution
      t.bigint :wallet_ticket_id
      t.integer :quantity
      t.decimal :price
      t.date :com_date

      t.timestamps
    end
  end
end
