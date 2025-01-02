namespace :import do
  desc "Consolidar Carteira"
  task consolidate_wallet: :environment do
    puts 'Consolidandado carteira...'
    Wallet.all.each do |wallet|
      wallet.wallet_tickets.where(finished: [false, nil]).each do |wallet_ticket|
        wallet_ticket.consolidate
        wallet_ticket.save
      end
    end
  end


  desc "Verifica ticker para encerrar"
  task verifica_carteira: :environment do
    
    Wallet.all.each do |wallet|
      wallet.wallet_tickets.where(finished: [false, nil]).each do |wallet_ticket|
        if wallet_ticket.quantity <= 0
          wallet_ticket.update_column(:finished, true)
        end
      end

      wallet.wallet_tickets.where(finished: [false, nil]).each do |wallet_ticket|
        quantity = 0
        ticket_moviment_ids = []
        puts wallet_ticket.ticket.name
        wallet_ticket.ticket_moviments.order(moviment_date: :asc).all.each do |ticket_moviment|
          if ticket_moviment.compra?
            quantity += ticket_moviment.quantity
          elsif ticket_moviment.venda?
            quantity -= ticket_moviment.quantity
          end

          ticket_moviment_ids << ticket_moviment.id

          if quantity == 0
            puts "finalizado"
            new_wallet_ticket = wallet_ticket.dup
            new_wallet_ticket.save

            wallet_ticket.update_column(:finished, true)

            wallet_ticket.ticket_moviments.where.not(id: ticket_moviment_ids).each do |ticket_moviment|
              ticket_moviment.update_column(:wallet_ticket_id, new_wallet_ticket.id)
            end
          end
        end

      end
    end
  end



  desc "Importa dados de todos os arquivos XLSX na pasta para o banco de dados"
  task negotiations: :environment do
    require 'roo'

    # Caminho da pasta com os arquivos
    folder_path = Rails.root.join('lib', 'assets', 'negociacao*.xlsx')

    # Iterar sobre cada arquivo XLSX na pasta
    Dir.glob(folder_path).each do |file_path|
      puts "Importando dados do arquivo: #{file_path}"

      # Abrir o arquivo Excel
      xlsx = Roo::Spreadsheet.open(file_path)

      # Assumindo que os dados começam na linha 2 (após o cabeçalho)
      xlsx.each_row_streaming(offset: 1, pad_cells: true) do |row|
        next if row[0].nil? # Ignorar linhas vazias

        # Mapear colunas para variáveis
        negotiation_date = Date.parse(row[0].cell_value) rescue nil
        moviment_type    = row[1].cell_value.downcase.strip
        institution      = row[4].cell_value
        ticket_code      = row[5].cell_value
        quantity         = row[6].cell_value.gsub(",", ".").to_i
        price            = row[7].cell_value.gsub(",", ".").to_f

        # Encontre ou crie os registros necessários
        ticket = Ticket.find_or_create_by!(name: ticket_code)
        wallet_ticket = WalletTicket.find_or_create_by!(
          ticket: ticket,
          wallet: Wallet.first # Ajuste para a carteira desejada
        )

        # Criar movimentação
        TicketMoviment.create!(
          wallet_ticket: wallet_ticket,
          moviment_date: negotiation_date,
          moviment_type: moviment_type, # Enum automático
          institution: institution,
          quantity: quantity,
          price: price
        )
      rescue => e
        puts "Erro ao processar linha: #{row.inspect}"
        puts e.message
      end
    end

    puts "Importação concluída!"
  end

  task movimentations: :environment do
    require 'roo'

    # Caminho da pasta com os arquivos
    folder_path = Rails.root.join('lib', 'assets', 'movimentacao*.xlsx')

    # Iterar sobre cada arquivo XLSX na pasta
    Dir.glob(folder_path).each do |file_path|
      puts "Importando dados do arquivo: #{file_path}"

      # Abrir o arquivo Excel
      xlsx = Roo::Spreadsheet.open(file_path)

      # Assumindo que os dados começam na linha 2 (após o cabeçalho)
      xlsx.each_row_streaming(offset: 1, pad_cells: true) do |row|
        next if row[0].nil? # Ignorar linhas vazias

        # Mapear colunas para variáveis
        negotiation_date = Date.parse(row[1].cell_value) rescue nil
        dividend_type    = row[2].cell_value.to_s.downcase
        ticket_code      = row[3].cell_value.split(" - ").first.to_s.strip
        institution      = row[4].cell_value
        quantity         = row[5].cell_value.gsub(",", ".").to_i
        price            = row[6].cell_value.gsub(",", ".").to_f

        # Encontre ou crie os registros necessários
        ticket = Ticket.find_or_create_by!(name: ticket_code)
        wallet_ticket = WalletTicket.find_or_create_by!(
          ticket: ticket,
          wallet: Wallet.first # Ajuste para a carteira desejada
        )

        case dividend_type
          when "dividendo"
            dividend_type = :dividendo
          when "rendimento"
            dividend_type = :rendimento
          when "juros sobre capital proprio"
            dividend_type = :jcp
          end

        # Criar movimentação
        TicketMoviment.create!(
          wallet_ticket: wallet_ticket,
          moviment_date: negotiation_date,
          moviment_type: :lucro, # Enum automático
          dividend_type: dividend_type,
          institution: institution,
          quantity: quantity,
          price: price
        )
      rescue => e
        puts "Erro ao processar linha: #{row.inspect}"
        puts e.message
      end
    end

    puts "Importação concluída!"
  end


  task update_stock_prices: :environment do
    ##UpdateStockPricesJob.perform_now

    API_URL = 'https://brapi.dev/api/quote/list'.freeze
    API_TOKEN = 'bDF4U5u6oDN5Ysp4K6bCcg'.freeze # Substitua pelo seu token de autenticação

    wallet_tickets = WalletTicket.joins(:ticket).select { |i| i.quantity > 0}

    return if wallet_tickets.empty?

    wallet_tickets.each do |wallet_ticket|
      uri = URI("#{API_URL}?search=#{wallet_ticket.ticket.name}&token=#{API_TOKEN}")

      response = Net::HTTP.get(uri)
      data = JSON.parse(response)


      if data["stocks"].present?
        puts "Importando dados de cotação para #{wallet_ticket.ticket.name}"
        current_price = data["stocks"][0]["close"]
        current_variation = data["stocks"][0]["change"]

        wallet_ticket.update_column(:current_price, current_price) if current_price.present?
        wallet_ticket.update_column(:current_variation, current_variation) if current_variation.present?
      end
    end

    Rake::Task['import:consolidate_wallet'].invoke
  end
end
