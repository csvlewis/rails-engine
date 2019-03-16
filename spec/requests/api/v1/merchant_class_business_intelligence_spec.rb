require 'rails_helper'

describe "Merchants API" do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)
    @merchant_4 = create(:merchant)
    date = '2019-03-12 19:31:18 UTC'
    invoice_1 = create(:invoice, merchant: @merchant_1, created_at: date, updated_at: date)
    invoice_2 = create(:invoice, merchant: @merchant_2)
    invoice_3 = create(:invoice, merchant: @merchant_3)
    invoice_4 = create(:invoice, merchant: @merchant_3)
    invoice_5 = create(:invoice, merchant: @merchant_4)
    create(:transaction, invoice: invoice_1)
    create(:transaction, invoice: invoice_2)
    create(:transaction, invoice: invoice_3)
    create(:transaction, invoice: invoice_4, result: 'failed')
    create(:transaction, invoice: invoice_5)
    create(:invoice_item, unit_price: 1000000, quantity: 2, invoice: invoice_1)
    create(:invoice_item, unit_price: 10000, quantity: 3, invoice: invoice_2)
    create(:invoice_item, unit_price: 100, quantity: 4, invoice: invoice_3)
    create(:invoice_item, unit_price: 100000000, quantity: 10, invoice: invoice_4)
    create(:invoice_item, unit_price: 1, quantity: 1, invoice: invoice_4)
  end
  it 'can return the top x merchants ranked by total revenue' do
    get '/api/v1/merchants/most_revenue?quantity=3'

    merchants = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchants["data"].count).to eq(3)
    expect(merchants["data"][0]["id"]).to eq(@merchant_1.id.to_s)
    expect(merchants["data"][1]["id"]).to eq(@merchant_2.id.to_s)
    expect(merchants["data"][2]["id"]).to eq(@merchant_3.id.to_s)
  end

  it 'can return the top x merchants ranked by total items sold' do
    get '/api/v1/merchants/most_items?quantity=3'

    merchants = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchants["data"].count).to eq(3)
    expect(merchants["data"][0]["id"]).to eq(@merchant_3.id.to_s)
    expect(merchants["data"][1]["id"]).to eq(@merchant_2.id.to_s)
    expect(merchants["data"][2]["id"]).to eq(@merchant_1.id.to_s)
  end

  it 'can return the total revenue for date x across all merchants' do
    get '/api/v1/merchants/revenue?date=2019-03-12'

    revenue = JSON.parse(response.body)

    expect(response).to be_successful
    expect(revenue["data"]["attributes"]["revenue"]).to eq("20000.00")
  end
end
