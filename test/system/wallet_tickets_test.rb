require "application_system_test_case"

class WalletTicketsTest < ApplicationSystemTestCase
  setup do
    @wallet_ticket = wallet_tickets(:one)
  end

  test "visiting the index" do
    visit wallet_tickets_url
    assert_selector "h1", text: "Wallet tickets"
  end

  test "should create wallet ticket" do
    visit wallet_tickets_url
    click_on "New wallet ticket"

    fill_in "Average price", with: @wallet_ticket.average_price
    fill_in "Ticket", with: @wallet_ticket.ticket_id
    fill_in "Wallet", with: @wallet_ticket.wallet_id
    click_on "Create Wallet ticket"

    assert_text "Wallet ticket was successfully created"
    click_on "Back"
  end

  test "should update Wallet ticket" do
    visit wallet_ticket_url(@wallet_ticket)
    click_on "Edit this wallet ticket", match: :first

    fill_in "Average price", with: @wallet_ticket.average_price
    fill_in "Ticket", with: @wallet_ticket.ticket_id
    fill_in "Wallet", with: @wallet_ticket.wallet_id
    click_on "Update Wallet ticket"

    assert_text "Wallet ticket was successfully updated"
    click_on "Back"
  end

  test "should destroy Wallet ticket" do
    visit wallet_ticket_url(@wallet_ticket)
    click_on "Destroy this wallet ticket", match: :first

    assert_text "Wallet ticket was successfully destroyed"
  end
end
