require 'rails_helper'

describe "Items API" do
  before :each do
    create_list(:item, 3)
  end
  it "can return an index of all items" do

    get "/api/v1/items.json"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(3)
  end

  it "can return an item by id" do
    id = create(:item).id

    get "/api/v1/items/#{id}.json"

    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item["data"]["attributes"]["id"]).to eq(id)
  end
end
