require 'rails_helper'

describe "Merchants API" do
  it "can search for a merchant with a query parameter" do
    date = '2019-03-12 19:31:18 UTC'
    assertion = '2019-03-12T19:31:18.000Z'
    merchant = create(:merchant, name: 'Searched Merchant', created_at: date, updated_at: date)
    id = merchant.id
    name = merchant.name
    create_list(:merchant, 5)

    get "/api/v1/merchants/find?id=#{id}"
    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["id"]).to eq(id)

    get "/api/v1/merchants/find?name=#{name}"
    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["name"]).to eq(name)

    get "/api/v1/merchants/find?created_at=#{date}"
    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["created_at"]).to eq(assertion)

    get "/api/v1/merchants/find?updated_at=#{date}"
    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["updated_at"]).to eq(assertion)
  end

  it "can search for all merchants matching a query parameter" do
    date = '2019-03-12 19:31:18 UTC'
    assertion = '2019-03-12T19:31:18.000Z'
    merchant = create(:merchant, name: 'Searched Merchant', created_at: date, updated_at: date)
    create(:merchant, name: 'Searched Merchant', created_at: date, updated_at: date)
    id = merchant.id
    name = merchant.name
    create_list(:merchant, 5)

    get "/api/v1/merchants/find_all?id=#{id}"
    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant.count).to eq(1)
    expect(merchant.first["id"]).to eq(id)

    get "/api/v1/merchants/find_all?name=#{name}"
    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant.count).to eq(2)
    expect(merchant.first["name"]).to eq(name)

    get "/api/v1/merchants/find_all?created_at=#{date}"
    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant.count).to eq(2)
    expect(merchant.first["created_at"]).to eq(assertion)

    get "/api/v1/merchants/find_all?updated_at=#{date}"
    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant.count).to eq(2)
    expect(merchant.first["updated_at"]).to eq(assertion)
  end

  describe "Merchants API" do
    it 'can return a random merchant' do
      create_list(:merchant, 10)

      ids = Merchant.all.map(&:id)

      get "/api/v1/merchants/random.json"

      merchant = JSON.parse(response.body)

      expect(response).to be_successful

      expect(ids).to include(merchant["id"])
    end
  end
end
