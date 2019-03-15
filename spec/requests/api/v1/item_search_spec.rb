require 'rails_helper'

describe "Items API" do
  before :each do
    merchant = create(:merchant)
    @date = '2019-03-12 19:31:18 UTC'
    @assertion = '2019-03-12T19:31:18.000Z'
    item = create(:item, name: 'name', description: 'description', unit_price: 2000, merchant_id: merchant.id, created_at: @date, updated_at: @date)
    @id = item.id
    @name = item.name
    @description = item.description
    @unit_price = item.unit_price
    @merchant_id = item.merchant_id
    create_list(:item, 5)
  end
  it "can search for an item with a query parameter" do
    get "/api/v1/items/find?id=#{@id}"
    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"]["id"]).to eq(@id.to_s)

    get "/api/v1/items/find?name=#{@name}"
    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"]["attributes"]["name"]).to eq(@name)

    get "/api/v1/items/find?description=#{@description}"
    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"]["attributes"]["description"]).to eq(@description)

    get "/api/v1/items/find?unit_price=#{@unit_price}"
    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"]["attributes"]["unit_price"]).to eq(@unit_price)

    get "/api/v1/items/find?merchant_id=#{@merchant_id}"
    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"]["attributes"]["merchant_id"]).to eq(@merchant_id)

    get "/api/v1/items/find?created_at=#{@date}"
    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"]["attributes"]["created_at"]).to eq(@assertion)

    get "/api/v1/items/find?updated_at=#{@date}"
    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"]["attributes"]["updated_at"]).to eq(@assertion)
  end
end
