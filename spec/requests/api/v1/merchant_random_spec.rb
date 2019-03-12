require 'rails_helper'

describe "Merchants API" do
  it 'can select a random merchant' do
    create_list(:merchant, 10)

    ids = Merchant.all.map(&:id)

    get "/api/v1/merchants/random.json"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful

    expect(ids).to include(merchant["id"])
  end
end
