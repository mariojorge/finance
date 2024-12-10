require "test_helper"

class TicketMovimentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ticket_moviment = ticket_moviments(:one)
  end

  test "should get index" do
    get ticket_moviments_url
    assert_response :success
  end

  test "should get new" do
    get new_ticket_moviment_url
    assert_response :success
  end

  test "should create ticket_moviment" do
    assert_difference("TicketMoviment.count") do
      post ticket_moviments_url, params: { ticket_moviment: { com_date: @ticket_moviment.com_date, institution: @ticket_moviment.institution, moviment_date: @ticket_moviment.moviment_date, price: @ticket_moviment.price, quantity: @ticket_moviment.quantity, moviment_type: @ticket_moviment.moviment_type, wallet_ticket_id: @ticket_moviment.wallet_ticket_id } }
    end

    assert_redirected_to ticket_moviment_url(TicketMoviment.last)
  end

  test "should show ticket_moviment" do
    get ticket_moviment_url(@ticket_moviment)
    assert_response :success
  end

  test "should get edit" do
    get edit_ticket_moviment_url(@ticket_moviment)
    assert_response :success
  end

  test "should update ticket_moviment" do
    patch ticket_moviment_url(@ticket_moviment), params: { ticket_moviment: { com_date: @ticket_moviment.com_date, institution: @ticket_moviment.institution, moviment_date: @ticket_moviment.moviment_date, price: @ticket_moviment.price, quantity: @ticket_moviment.quantity, moviment_type: @ticket_moviment.moviment_type, wallet_ticket_id: @ticket_moviment.wallet_ticket_id } }
    assert_redirected_to ticket_moviment_url(@ticket_moviment)
  end

  test "should destroy ticket_moviment" do
    assert_difference("TicketMoviment.count", -1) do
      delete ticket_moviment_url(@ticket_moviment)
    end

    assert_redirected_to ticket_moviments_url
  end
end
