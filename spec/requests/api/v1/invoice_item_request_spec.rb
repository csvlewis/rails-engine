require 'rails_helper'

describe "Invoice_items API" do
  before :each do
    create_list(:invoice_item, 3)
  end
  it "can return an index of all invoice items" do

    get "/api/v1/invoice_items.json"

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)

    expect(invoice_items["data"].count).to eq(3)
  end

  it "can return an invoice_item by id" do
    id = create(:invoice_item).id

    get "/api/v1/invoice_items/#{id}.json"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)

    expect(invoice_item["data"]["attributes"]["id"]).to eq(id)
  end
end
