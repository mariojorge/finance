class AddFinishedToWalletTicket < ActiveRecord::Migration[8.0]
  def change
    add_column :wallet_tickets, :finished, :boolean

    WalletTicket.where(finished: nil).update_all(finished: false)
  end
end
