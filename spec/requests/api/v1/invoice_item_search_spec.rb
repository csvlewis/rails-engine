require 'rails_helper'

describe "Invoice_items API" do
  before :each do
    item = create(:item)
    invoice = create(:invoice)
    @date = '2019-03-12 19:31:18 UTC'
    @invoice_item = create(:invoice_item, quantity: 1, unit_price: 100, item_id: item.id, invoice_id: invoice.id, created_at: @date, updated_at: @date)
    @id = @invoice_item.id
    @quantity = @invoice_item.quantity
    @unit_price = @invoice_item.unit_price.to_s.insert(-3, '.')
    @item_id = @invoice_item.item_id
    @invoice_id = @invoice_item.invoice_id
    create_list(:invoice_item, 5)
  end
  it "can search for an invoice_item with a query parameter" do
    get "/api/v1/invoice_items/find?id=#{@id}"
    invoice_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item["data"]["id"]).to eq(@id.to_s)

    get "/api/v1/invoice_items/find?quantity=#{@quantity}"
    invoice_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item["data"]["attributes"]["quantity"]).to eq(@quantity)

    get "/api/v1/invoice_items/find?unit_price=#{@unit_price}"
    invoice_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item["data"]["attributes"]["unit_price"]).to eq(@unit_price)

    get "/api/v1/invoice_items/find?item_id=#{@item_id}"
    invoice_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item["data"]["attributes"]["item_id"]).to eq(@item_id)

    get "/api/v1/invoice_items/find?invoice_id=#{@invoice_id}"
    invoice_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item["data"]["attributes"]["invoice_id"]).to eq(@invoice_id)

    get "/api/v1/invoice_items/find?created_at=#{@date}"
    invoice_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item["data"]["id"]).to eq(@id.to_s)

    get "/api/v1/invoice_items/find?updated_at=#{@date}"
    invoice_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item["data"]["id"]).to eq(@id.to_s)
  end

  it "can search for all invoice_items matching a query parameter" do
    create(:invoice_item, quantity: 1, unit_price: 100, item_id: @item_id, invoice_id: @invoice_id, created_at: @date, updated_at: @date)

    get "/api/v1/invoice_items/find_all?id=#{@id}"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item["data"].count).to eq(1)
    expect(invoice_item["data"].first["id"]).to eq(@id.to_s)

    get "/api/v1/invoice_items/find_all?quantity=#{@quantity}"
    invoice_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item["data"].count).to eq(2)
    expect(invoice_item["data"].first["attributes"]["quantity"]).to eq(@quantity)

    get "/api/v1/invoice_items/find_all?unit_price=#{@unit_price}"
    invoice_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item["data"].count).to eq(2)
    expect(invoice_item["data"].first["attributes"]["unit_price"]).to eq(@unit_price)

    get "/api/v1/invoice_items/find_all?item_id=#{@item_id}"
    invoice_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item["data"].count).to eq(2)
    expect(invoice_item["data"].first["attributes"]["item_id"]).to eq(@item_id)

    get "/api/v1/invoice_items/find_all?invoice_id=#{@invoice_id}"
    invoice_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item["data"].count).to eq(2)
    expect(invoice_item["data"].first["attributes"]["invoice_id"]).to eq(@invoice_id)

    get "/api/v1/invoice_items/find_all?created_at=#{@date}"
    invoice_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item["data"].count).to eq(2)
    expect(invoice_item["data"].first["id"]).to eq(@id.to_s)

    get "/api/v1/invoice_items/find_all?updated_at=#{@date}"
    invoice_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item["data"].count).to eq(2)
    expect(invoice_item["data"].first["id"]).to eq(@id.to_s)
  end

  it 'can return a random invoice_item' do
    create_list(:invoice_item, 10)

    ids = InvoiceItem.all.map(&:id)

    get "/api/v1/invoice_items/random.json"


    invoice_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(ids).to include(invoice_item["data"]["id"].to_i)
  end
end
