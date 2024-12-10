class TicketMovimentsController < ApplicationController
  before_action :set_ticket_moviment, only: %i[ show edit update destroy ]

  # GET /ticket_moviments or /ticket_moviments.json
  def index
    @ticket_moviments = TicketMoviment.all
  end

  # GET /ticket_moviments/1 or /ticket_moviments/1.json
  def show
  end

  # GET /ticket_moviments/new
  def new
    @ticket_moviment = TicketMoviment.new(wallet_ticket_id: params[:wallet_ticket_id], moviment_type: params[:moviment_type])
  end

  # GET /ticket_moviments/1/edit
  def edit
  end

  # POST /ticket_moviments or /ticket_moviments.json
  def create
    @ticket_moviment = TicketMoviment.new(ticket_moviment_params)

    respond_to do |format|
      if @ticket_moviment.save
        format.html { redirect_to @ticket_moviment.wallet_ticket, notice: "Ticket moviment was successfully created." }
        format.json { render :show, status: :created, location: @ticket_moviment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ticket_moviment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ticket_moviments/1 or /ticket_moviments/1.json
  def update
    respond_to do |format|
      if @ticket_moviment.update(ticket_moviment_params)
        format.html { redirect_to @ticket_moviment.wallet_ticket, notice: "Ticket moviment was successfully updated." }
        format.json { render :show, status: :ok, location: @ticket_moviment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ticket_moviment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ticket_moviments/1 or /ticket_moviments/1.json
  def destroy
    @ticket_moviment.destroy!

    respond_to do |format|
      format.html { redirect_to ticket_moviments_path, status: :see_other, notice: "Ticket moviment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket_moviment
      @ticket_moviment = TicketMoviment.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def ticket_moviment_params
      params.expect(ticket_moviment: [ :moviment_type, :moviment_date, :institution, :wallet_ticket_id, :quantity, :price, :com_date ])
    end
end
