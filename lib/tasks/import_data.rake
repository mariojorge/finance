namespace :import do
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
    UpdateStockPricesJob.perform_now
  end
end
