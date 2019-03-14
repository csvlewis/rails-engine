require 'rails_helper'

describe "Customers API" do
  before :each do
    create_list(:invoice, 5)
    create_list(:transaction, 5)

    customer = create(:customer)
    @id = customer.id
    invoices = create_list(:invoice, 5, customer: customer)
    create(:transaction, invoice: invoices[0])
    create(:transaction, invoice: invoices[1])
    create(:transaction, invoice: invoices[2])
    create(:transaction, invoice: invoices[3])
    create(:transaction, invoice: invoices[4])
  end
  it 'can return all invoices associated with a customer' do
    get "/api/v1/customers/#{@id}/invoices"

    invoices = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoices["data"].count).to eq(5)
  end

  it 'can return all transactions associated with a customer' do
    get "/api/v1/customers/#{@id}/transactions"

    transactions = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transactions["data"].count).to eq(5)
  end
end
