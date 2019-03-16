require 'rails_helper'

describe "Items API" do
  before :each do
    create_list(:invoice_item, 5)
    create_list(:merchant, 5)

    @merchant = create(:merchant)
    item = create(:item, merchant_id: @merchant.id)
    @id = item.id
    create_list(:invoice_item, 5, item_id: @id)
  end
  it 'can return all invoice_items associated with an item' do
    get "/api/v1/items/#{@id}/invoice_items"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_items["data"].count).to eq(5)
  end

  it 'can return the merchant associated with an item' do
    get "/api/v1/items/#{@id}/merchant"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"]["id"]).to eq(@merchant.id.to_s)
  end
end
