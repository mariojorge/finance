class WalletTicketsController < ApplicationController
  before_action :set_wallet_ticket, only: %i[ show edit update destroy ]

  # GET /wallet_tickets or /wallet_tickets.json
  def index
    @wallet_tickets = WalletTicket.all
  end

  # GET /wallet_tickets/1 or /wallet_tickets/1.json
  def show
  end

  # GET /wallet_tickets/new
  def new
    @wallet_ticket = WalletTicket.new(wallet_id: params[:wallet_id])
  end

  # GET /wallet_tickets/1/edit
  def edit
  end

  # POST /wallet_tickets or /wallet_tickets.json
  def create
    @wallet_ticket = WalletTicket.new(wallet_ticket_params)

    respond_to do |format|
      if @wallet_ticket.save
        format.html { redirect_to @wallet_ticket.wallet, notice: "Wallet ticket was successfully created." }
        format.json { render :show, status: :created, location: @wallet_ticket }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @wallet_ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wallet_tickets/1 or /wallet_tickets/1.json
  def update
    respond_to do |format|
      if @wallet_ticket.update(wallet_ticket_params)
        format.html { redirect_to @wallet_ticket.wallet, notice: "Wallet ticket was successfully updated." }
        format.json { render :show, status: :ok, location: @wallet_ticket }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @wallet_ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wallet_tickets/1 or /wallet_tickets/1.json
  def destroy
    @wallet_ticket.destroy!

    respond_to do |format|
      format.html { redirect_to wallet_tickets_path, status: :see_other, notice: "Wallet ticket was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wallet_ticket
      @wallet_ticket = WalletTicket.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def wallet_ticket_params
      params.expect(wallet_ticket: [ :wallet_id, :ticket_id, :average_price ])
    end
end
