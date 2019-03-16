require 'rails_helper'

describe "Invoices API" do
  before :each do
    create_list(:invoice, 3)
  end
  it "can return an index of all invoices" do

    get "/api/v1/invoices.json"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices["data"].count).to eq(3)
  end

  it "can return an invoice by id" do
    id = create(:invoice).id

    get "/api/v1/invoices/#{id}.json"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)

    expect(invoice["data"]["attributes"]["id"]).to eq(id)
  end
end
