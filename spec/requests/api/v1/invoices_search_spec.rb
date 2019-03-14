require 'rails_helper'

describe "Invoices API" do
  it "can search for an invoice with a query parameter" do
    date = '2019-03-12 19:31:18 UTC'
    assertion = '2019-03-12T19:31:18.000Z'
    invoice = create(:invoice, created_at: date, updated_at: date)
    id = invoice.id
    status = invoice.status
    customer_id = invoice.customer_id
    merchant_id = invoice.merchant_id
    create_list(:invoice, 5)

    get "/api/v1/invoices/find?id=#{id}"
    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["id"]).to eq(id)

    get "/api/v1/invoices/find?status=#{status}"
    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["status"]).to eq(status)

    get "/api/v1/invoices/find?customer_id=#{customer_id}"
    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["customer_id"]).to eq(customer_id)

    get "/api/v1/invoices/find?merchant_id=#{merchant_id}"
    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["merchant_id"]).to eq(merchant_id)

    get "/api/v1/invoices/find?created_at=#{date}"
    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["created_at"]).to eq(assertion)

    get "/api/v1/invoices/find?updated_at=#{date}"
    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["updated_at"]).to eq(assertion)
  end

  it 'can search for all invoices matching a query parameter' do
    date = '2019-03-12 19:31:18 UTC'
    assertion = '2019-03-12T19:31:18.000Z'
    customer = create(:customer, id: 1)
    merchant = create(:merchant, id: 1)
    invoice = create(:invoice, status: 'incomplete', customer_id: customer.id, merchant_id: merchant.id, created_at: date, updated_at: date)
    create(:invoice, status: 'incomplete', customer_id: customer.id, merchant_id: merchant.id,  created_at: date, updated_at: date)
    id = invoice.id
    status = invoice.status
    customer_id = invoice.customer_id
    merchant_id = invoice.merchant_id
    create_list(:invoice, 5)

    get "/api/v1/invoices/find_all?id=#{id}"
    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice.count).to eq(1)
    expect(invoice.first["id"]).to eq(id)

    get "/api/v1/invoices/find_all?status=#{status}"
    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice.count).to eq(2)
    expect(invoice.first["status"]).to eq(status)

    get "/api/v1/invoices/find_all?customer_id=#{customer_id}"
    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice.count).to eq(2)
    expect(invoice.first["customer_id"]).to eq(customer_id)

    get "/api/v1/invoices/find_all?merchant_id=#{merchant_id}"
    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice.count).to eq(2)
    expect(invoice.first["merchant_id"]).to eq(merchant_id)

    get "/api/v1/invoices/find_all?created_at=#{date}"
    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice.count).to eq(2)
    expect(invoice.first["created_at"]).to eq(assertion)

    get "/api/v1/invoices/find_all?updated_at=#{date}"
    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice.count).to eq(2)
    expect(invoice.first["updated_at"]).to eq(assertion)
  end
end
