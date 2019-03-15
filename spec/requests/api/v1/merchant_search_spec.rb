require 'rails_helper'

describe "Merchants API" do
  before :each do
    @date = '2019-03-12 19:31:18 UTC'
    @assertion = '2019-03-12T19:31:18.000Z'
    merchant = create(:merchant, name: 'Searched Merchant', created_at: @date, updated_at: @date)
    @id = merchant.id
    @name = merchant.name
    create_list(:merchant, 5)
  end
  it "can search for a merchant with a query parameter" do
    get "/api/v1/merchants/find?id=#{@id}"
    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"]["id"]).to eq(@id.to_s)

    get "/api/v1/merchants/find?name=#{@name}"
    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"]["attributes"]["name"]).to eq(@name)

    get "/api/v1/merchants/find?created_at=#{@date}"
    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"]["attributes"]["created_at"]).to eq(@assertion)

    get "/api/v1/merchants/find?updated_at=#{@date}"
    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"]["attributes"]["updated_at"]).to eq(@assertion)
  end

  it "can search for all merchants matching a query parameter" do
    create(:merchant, name: 'Searched Merchant', created_at: @date, updated_at: @date)

    get "/api/v1/merchants/find_all?id=#{@id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"].count).to eq(1)
    expect(merchant["data"].first["id"]).to eq(@id.to_s)

    get "/api/v1/merchants/find_all?name=#{@name}"
    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"].count).to eq(2)
    expect(merchant["data"].first["attributes"]["name"]).to eq(@name)

    get "/api/v1/merchants/find_all?created_at=#{@date}"
    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"].count).to eq(2)
    expect(merchant["data"].first["attributes"]["created_at"]).to eq(@assertion)

    get "/api/v1/merchants/find_all?updated_at=#{@date}"
    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"].count).to eq(2)
    expect(merchant["data"].first["attributes"]["updated_at"]).to eq(@assertion)
  end

  it 'can return a random merchant' do
    create_list(:merchant, 10)

    ids = Merchant.all.map(&:id)

    get "/api/v1/merchants/random.json"


    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(ids).to include(merchant["data"]["id"].to_i)
  end
end
