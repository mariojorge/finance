require "application_system_test_case"

class TicketMovimentsTest < ApplicationSystemTestCase
  setup do
    @ticket_moviment = ticket_moviments(:one)
  end

  test "visiting the index" do
    visit ticket_moviments_url
    assert_selector "h1", text: "Ticket moviments"
  end

  test "should create ticket moviment" do
    visit ticket_moviments_url
    click_on "New ticket moviment"

    fill_in "Com date", with: @ticket_moviment.com_date
    fill_in "Institution", with: @ticket_moviment.institution
    fill_in "Moviment date", with: @ticket_moviment.moviment_date
    fill_in "Price", with: @ticket_moviment.price
    fill_in "Quantity", with: @ticket_moviment.quantity
    fill_in "Type", with: @ticket_moviment.moviment_type
    fill_in "Wallet ticket", with: @ticket_moviment.wallet_ticket_id
    click_on "Create Ticket moviment"

    assert_text "Ticket moviment was successfully created"
    click_on "Back"
  end

  test "should update Ticket moviment" do
    visit ticket_moviment_url(@ticket_moviment)
    click_on "Edit this ticket moviment", match: :first

    fill_in "Com date", with: @ticket_moviment.com_date
    fill_in "Institution", with: @ticket_moviment.institution
    fill_in "Moviment date", with: @ticket_moviment.moviment_date
    fill_in "Price", with: @ticket_moviment.price
    fill_in "Quantity", with: @ticket_moviment.quantity
    fill_in "Type", with: @ticket_moviment.moviment_type
    fill_in "Wallet ticket", with: @ticket_moviment.wallet_ticket_id
    click_on "Update Ticket moviment"

    assert_text "Ticket moviment was successfully updated"
    click_on "Back"
  end

  test "should destroy Ticket moviment" do
    visit ticket_moviment_url(@ticket_moviment)
    click_on "Destroy this ticket moviment", match: :first

    assert_text "Ticket moviment was successfully destroyed"
  end
end
