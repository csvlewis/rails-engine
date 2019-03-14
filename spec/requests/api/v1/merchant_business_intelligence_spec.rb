require 'rails_helper'

describe "Merchants API" do
  before :each do
    @merchant = create(:merchant)
    @invoice = create(:invoice, merchant: @merchant)
    @invoice_2 = create(:invoice, merchant: @merchant)
    create(:transaction, invoice: @invoice)
    create(:transaction, invoice: @invoice_2, result: 'failed' )
    create_list(:invoice_item, 5, invoice: @invoice)
    create_list(:invoice_item, 5, invoice: @invoice_2)
    @id = @merchant.id
  end
  it 'can return the total revenue for a merchant across successful transactions' do
    get "/api/v1/merchants/#{@id}/revenue"

    revenue = JSON.parse(response.body)

    expect(response).to be_successful
    expect(revenue["data"].first["attributes"]["revenue"]).to eq(500000)
  end
end
