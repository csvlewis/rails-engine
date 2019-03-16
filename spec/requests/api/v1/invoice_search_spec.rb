require 'rails_helper'

describe "Invoices API" do
  before :each do
    customer = create(:customer)
    merchant = create(:merchant)
    @date = '2019-03-12 19:31:18 UTC'
    invoice = create(:invoice, status: 'incomplete', customer_id: customer.id, merchant_id: merchant.id, created_at: @date, updated_at: @date)
    @id = invoice.id
    @status = invoice.status
    @customer_id = invoice.customer_id
    @merchant_id = invoice.merchant_id
    create_list(:invoice, 5)
  end
  it "can search for an invoice with a query parameter" do
    get "/api/v1/invoices/find?id=#{@id}"
    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["data"]["id"]).to eq(@id.to_s)

    get "/api/v1/invoices/find?status=#{@status}"
    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["data"]["attributes"]["status"]).to eq(@status)

    get "/api/v1/invoices/find?customer_id=#{@customer_id}"
    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["data"]["attributes"]["customer_id"]).to eq(@customer_id)

    get "/api/v1/invoices/find?merchant_id=#{@merchant_id}"
    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["data"]["attributes"]["merchant_id"]).to eq(@merchant_id)

    get "/api/v1/invoices/find?created_at=#{@date}"
    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["data"]["id"]).to eq(@id.to_s)

    get "/api/v1/invoices/find?updated_at=#{@date}"
    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["data"]["id"]).to eq(@id.to_s)
  end

  it 'can search for all invoices matching a query parameter' do
    create(:invoice, status: 'incomplete', customer_id: @customer_id, merchant_id: @merchant_id,  created_at: @date, updated_at: @date)

    get "/api/v1/invoices/find_all?id=#{@id}"
    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice.count).to eq(1)
    expect(invoice["data"].first["id"]).to eq(@id.to_s)

    get "/api/v1/invoices/find_all?status=#{@status}"
    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["data"].count).to eq(2)
    expect(invoice["data"].first["attributes"]["status"]).to eq(@status)

    get "/api/v1/invoices/find_all?customer_id=#{@customer_id}"
    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["data"].count).to eq(2)
    expect(invoice["data"].first["attributes"]["customer_id"]).to eq(@customer_id)

    get "/api/v1/invoices/find_all?merchant_id=#{@merchant_id}"
    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["data"].count).to eq(2)
    expect(invoice["data"].first["attributes"]["merchant_id"]).to eq(@merchant_id)

    get "/api/v1/invoices/find_all?created_at=#{@date}"
    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["data"].count).to eq(2)
    expect(invoice["data"].first["id"]).to eq(@id.to_s)

    get "/api/v1/invoices/find_all?updated_at=#{@date}"
    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["data"].count).to eq(2)
    expect(invoice["data"].first["id"]).to eq(@id.to_s)
  end

  it "can search for a random invoice" do
    create_list(:invoice, 10)

    ids = Invoice.all.map(&:id)

    get "/api/v1/invoices/random.json"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(ids).to include(invoice["data"]["id"].to_i)
  end
end
