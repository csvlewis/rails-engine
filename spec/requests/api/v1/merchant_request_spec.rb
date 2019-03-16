require 'rails_helper'

describe "Merchants API" do
  before :each do
    @id = create(:merchant).id
    create_list(:merchant, 2)
  end
  it "can return an index of all merchants" do
    get "/api/v1/merchants.json"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"].count).to eq(3)
  end

  it "can return a merchant by id" do
    get "/api/v1/merchants/#{@id}.json"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant["data"]["id"]).to eq(@id.to_s)
  end
end
