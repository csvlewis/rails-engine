require 'rails_helper'

describe "Merchants API" do
  before :each do
    @date = '2019-03-12 19:31:18 UTC'
    @assertion = '2019-03-12T19:31:18.000Z'
    @merchant = create(:merchant)
    @invoice = create(:invoice, merchant: @merchant, created_at: @date, updated_at: @date)
    @invoice_2 = create(:invoice, merchant: @merchant)
    @invoice_3 = create(:invoice, merchant: @merchant)
    create(:transaction, invoice: @invoice)
    create(:transaction, invoice: @invoice_2, result: 'failed')
    create(:transaction, invoice: @invoice_3)
    create_list(:invoice_item, 5, invoice: @invoice)
    create_list(:invoice_item, 5, invoice: @invoice_2)
    create_list(:invoice_item, 5, invoice: @invoice_3)
    @id = @merchant.id
  end
  it 'can return the total revenue for a merchant across successful transactions' do
    get "/api/v1/merchants/#{@id}/revenue"

    revenue = JSON.parse(response.body)

    expect(response).to be_successful
    expect(revenue["data"].first["attributes"]["revenue"]).to eq('10000.00')
  end

  it 'can return the total revenue for a merchant across successful transactions on invoice date x' do
    get "/api/v1/merchants/#{@id}/revenue?date=2019-03-12"

    revenue = JSON.parse(response.body)

    expect(response).to be_successful
    expect(revenue["data"].first["attributes"]["revenue"]).to eq("5000.00")
  end
end
