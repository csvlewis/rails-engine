require 'rails_helper'

describe 'Items API' do
  before :each do
    date_1 = '2019-03-14 19:31:18 UTC'
    date_2 = '2019-03-12 19:31:18 UTC'
    @assertion = '2019-03-14'
    @item_1 = create(:item, name: 'Item 1')
    @item_2 = create(:item, name: 'Item 2')
    @item_3 = create(:item, name: 'Item 3')
    invoice_1 = create(:invoice, created_at: date_1, updated_at: date_1)
    invoice_2 = create(:invoice, created_at: date_1, updated_at: date_1)
    invoice_3 = create(:invoice, created_at: date_2, updated_at: date_2)
    invoice_4 = create(:invoice)
    invoice_5 = create(:invoice)
    create(:transaction, invoice: invoice_1)
    create(:transaction, invoice: invoice_2)
    create(:transaction, invoice: invoice_3)
    create(:transaction, invoice: invoice_4)
    create(:transaction, invoice: invoice_5)
    create(:invoice_item, unit_price: 1000000, quantity: 1, invoice: invoice_1, item: @item_1)
    create(:invoice_item, unit_price: 100, quantity: 1, invoice: invoice_2, item: @item_1)
    create(:invoice_item, unit_price: 100, quantity: 1, invoice: invoice_3, item: @item_1)
    create(:invoice_item, unit_price: 10000, quantity: 5, invoice: invoice_4, item: @item_2)
    create(:invoice_item, unit_price: 100, quantity: 10, invoice: invoice_5, item: @item_3)
  end
  it 'can return the top x items ranked by total revenue generated' do
    get "/api/v1/items/most_revenue?quantity=3"

    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items["data"][0]["id"]).to eq(@item_1.id.to_s)
    expect(items["data"][1]["id"]).to eq(@item_2.id.to_s)
    expect(items["data"][2]["id"]).to eq(@item_3.id.to_s)
  end

  it 'can return the top x items ranked by quantity sold' do
    get "/api/v1/items/most_items?quantity=3"

    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items["data"][0]["id"]).to eq(@item_3.id.to_s)
    expect(items["data"][1]["id"]).to eq(@item_2.id.to_s)
    expect(items["data"][2]["id"]).to eq(@item_1.id.to_s)
  end

  it 'can return the date with the most sales for the given item' do
    get "/api/v1/items/#{@item_1.id}/best_day"

    date = JSON.parse(response.body)

    expect(response).to be_successful
    expect(date["data"]["attributes"]["best_day"]).to eq(@assertion)
  end
end
