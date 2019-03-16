require 'rails_helper'

describe "Invoice_items API" do
  before :each do
    create_list(:item, 5)
    create_list(:invoice, 5)

    @item = create(:item)
    @invoice = create(:invoice)
    invoice_item = create(:invoice_item, item: @item, invoice: @invoice)
    @id = invoice_item.id
  end
  it 'can return the item associated with an invoice_item' do
    get "/api/v1/invoice_items/#{@id}/item"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"]["id"]).to eq(@item.id.to_s)
  end

  it 'can return the invoice associated with an invoice_item' do
    get "/api/v1/invoice_items/#{@id}/invoice"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["data"]["id"]).to eq(@invoice.id.to_s)
  end
end
