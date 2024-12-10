require "test_helper"

class WalletTicketsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wallet_ticket = wallet_tickets(:one)
  end

  test "should get index" do
    get wallet_tickets_url
    assert_response :success
  end

  test "should get new" do
    get new_wallet_ticket_url
    assert_response :success
  end

  test "should create wallet_ticket" do
    assert_difference("WalletTicket.count") do
      post wallet_tickets_url, params: { wallet_ticket: { average_price: @wallet_ticket.average_price, ticket_id: @wallet_ticket.ticket_id, wallet_id: @wallet_ticket.wallet_id } }
    end

    assert_redirected_to wallet_ticket_url(WalletTicket.last)
  end

  test "should show wallet_ticket" do
    get wallet_ticket_url(@wallet_ticket)
    assert_response :success
  end

  test "should get edit" do
    get edit_wallet_ticket_url(@wallet_ticket)
    assert_response :success
  end

  test "should update wallet_ticket" do
    patch wallet_ticket_url(@wallet_ticket), params: { wallet_ticket: { average_price: @wallet_ticket.average_price, ticket_id: @wallet_ticket.ticket_id, wallet_id: @wallet_ticket.wallet_id } }
    assert_redirected_to wallet_ticket_url(@wallet_ticket)
  end

  test "should destroy wallet_ticket" do
    assert_difference("WalletTicket.count", -1) do
      delete wallet_ticket_url(@wallet_ticket)
    end

    assert_redirected_to wallet_tickets_url
  end
end
