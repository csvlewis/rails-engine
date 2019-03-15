require 'rails_helper'

describe "Transactions API" do
  it 'can return the invoice associated with a transaction' do
    create_list(:invoice, 5)

    invoice = create(:invoice)
    invoice_id = invoice.id
    transaction = create(:transaction, invoice: invoice)
    id = transaction.id

    get "/api/v1/transactions/#{id}/invoice"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["data"]["id"]).to eq(invoice_id.to_s)
  end
end
