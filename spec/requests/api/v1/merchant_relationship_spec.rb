require 'rails_helper'

describe "Merchants API" do
  before :each do
    create_list(:item, 5)
    create_list(:invoice, 5)

    merchant = create(:merchant)
    @id = merchant.id
    create_list(:item, 5, merchant: merchant)
    create_list(:invoice, 5, merchant: merchant)
  end
  it 'can return all items associated with a merchant' do
    get "/api/v1/merchants/#{@id}/items"

    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items["data"].count).to eq(5)
  end

  it 'can return all invoices associated with a merchant' do
    get "/api/v1/merchants/#{@id}/invoices"

    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items["data"].count).to eq(5)
  end
end
