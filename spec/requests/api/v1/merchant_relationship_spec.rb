require 'rails_helper'

describe "Merchants API" do
  it 'can return all items associated with a merchant' do
    merchant = create(:merchant)
    create_list(:item, 5, merchant: merchant)
    id = merchant.id

    get "/api/v1/merchants/#{id}/items"

    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items.count).to eq(5)
  end

  it 'can return all invoices associated with a merchant' do
    merchant = create(:merchant)
    create_list(:invoice, 5, merchant: merchant)
    id = merchant.id

    get "/api/v1/merchants/#{id}/invoices"

    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items.count).to eq(5)
  end
end
