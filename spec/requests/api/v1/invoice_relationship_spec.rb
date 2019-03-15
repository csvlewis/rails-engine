require 'rails_helper'

describe "Invoices API" do
  before :each do
    create_list(:transaction, 5)
    create_list(:invoice_item, 5)
    create_list(:item, 5)
    create_list(:customer, 5)
    create_list(:merchant, 5)

    @customer = create(:customer)
    @merchant = create(:merchant)
    invoice = create(:invoice, customer_id: @customer.id, merchant_id: @merchant.id)
    @id = invoice.id
    create_list(:transaction, 5, invoice_id: @id)
    items = create_list(:item, 5)
    create(:invoice_item, item_id: items[0].id, invoice_id: @id)
    create(:invoice_item, item_id: items[1].id, invoice_id: @id)
    create(:invoice_item, item_id: items[2].id, invoice_id: @id)
    create(:invoice_item, item_id: items[3].id, invoice_id: @id)
    create(:invoice_item, item_id: items[4].id, invoice_id: @id)
  end
  it 'can return all transactions associated with an invoice' do
    get "/api/v1/invoices/#{@id}/transactions"

    transactions = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transactions["data"].count).to eq(5)
  end

  it 'can return all invoice_items associated with an invoice' do
    get "/api/v1/invoices/#{@id}/invoice_items"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_items["data"].count).to eq(5)
  end

  it 'can return all items associated with an invoice' do
    get "/api/v1/invoices/#{@id}/items"

    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items["data"].count).to eq(5)
  end

  it 'can return the customer associated with an invoice' do
    get "/api/v1/invoices/#{@id}/customer"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["data"]["id"]).to eq(@customer.id.to_s)
  end

  it 'can return the merchant associated with an invoice' do
    get "/api/v1/invoices/#{@id}/merchant"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"]["id"]).to eq(@merchant.id.to_s)
  end
end
