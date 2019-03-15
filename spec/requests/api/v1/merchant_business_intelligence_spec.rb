require 'rails_helper'

describe "Merchants API" do
  before :each do
    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @date = '2019-03-12 19:31:18 UTC'
    @assertion = '2019-03-12T19:31:18.000Z'
    @merchant = create(:merchant)
    @invoice = create(:invoice, merchant: @merchant, created_at: @date, updated_at: @date, customer_id: @customer_1.id)
    @invoice_2 = create(:invoice, merchant: @merchant, customer_id: @customer_1.id)
    @invoice_3 = create(:invoice, merchant: @merchant, customer_id: @customer_2.id)
    @invoice_4 = create(:invoice, merchant: @merchant, customer_id: @customer_2.id)
    create(:transaction, invoice: @invoice)
    create(:transaction, invoice: @invoice_2, result: 'failed')
    create(:transaction, invoice: @invoice_3)
    create(:transaction, invoice: @invoice_4)
    create_list(:invoice_item, 1, unit_price: 100, quantity: 5, invoice: @invoice)
    create_list(:invoice_item, 1, unit_price: 100, quantity: 5, invoice: @invoice_2)
    create_list(:invoice_item, 1, unit_price: 100, quantity: 5, invoice: @invoice_3)
    create_list(:invoice_item, 1, unit_price: 100, quantity: 5, invoice: @invoice_4)
    @id = @merchant.id
  end
  it 'can return the total revenue for a merchant across successful transactions' do
    get "/api/v1/merchants/#{@id}/revenue"

    revenue = JSON.parse(response.body)

    expect(response).to be_successful
    expect(revenue["data"].first["attributes"]["revenue"]).to eq('15.00')
  end

  it 'can return the total revenue for a merchant across successful transactions on invoice date x' do
    get "/api/v1/merchants/#{@id}/revenue?date=2019-03-12"

    revenue = JSON.parse(response.body)

    expect(response).to be_successful
    expect(revenue["data"].first["attributes"]["revenue"]).to eq("5.00")
  end

  it 'can return the customer who has conducted the most successful transactions with this merchant' do
    get "/api/v1/merchants/#{@id}/favorite_customer"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["data"].first["id"]).to eq(@customer_2.id.to_s)
  end
end
