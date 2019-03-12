require 'rails_helper'

describe "Merchants API" do
  it "can return all merchant records" do
    create_list(:merchant, 3)

    get "/api/v1/merchants.json"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants.count).to eq(3)
  end

  it "can return a merchant record by id" do
    id = create(:merchant).id
    create_list(:merchant, 3)

    get "/api/v1/merchants/#{id}.json"

    expect(response).to be_successful

    merchant = JSON.parse(response.body).symbolize_keys

    expect(merchant[:id]).to eq(id)
  end
end
