require 'rails_helper'

describe "Invoices API" do
  it "can return an index of all invoices" do
    create_list(:invoice, 3)

    get "/api/v1/invoices.json"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices.count).to eq(3)
  end

  it "can return an invoice by id" do
    id = create(:invoice).id
    create_list(:invoice, 3)

    get "/api/v1/invoices/#{id}.json"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)

    expect(invoice["id"]).to eq(id)
  end
end
