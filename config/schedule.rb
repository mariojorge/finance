set :output, 'log/cron.log'

every 1.day, at: '00:00 am' do
  runner 'UpdateStockPricesJob.perform_later'
end