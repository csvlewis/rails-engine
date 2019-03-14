require 'rails_helper'

describe "Merchants API" do
  it "can return an index of all merchants" do
    create_list(:merchant, 3)

    get "/api/v1/merchants.json"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants.count).to eq(3)
  end

  it "can return a merchant by id" do
    id = create(:merchant).id
    create_list(:merchant, 3)

    get "/api/v1/merchants/#{id}.json"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant["id"]).to eq(id)
  end
end
