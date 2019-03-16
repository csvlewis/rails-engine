require 'rails_helper'

describe "Transactions API" do
  before :each do
    invoice = create(:invoice)
    @date = '2019-03-12 19:31:18 UTC'
    transaction = create(:transaction, credit_card_number: '1', credit_card_expiration_date: '1', result: 'result', invoice_id: invoice.id, created_at: @date, updated_at: @date)
    @id = transaction.id
    @credit_card_number = transaction.credit_card_number
    @credit_card_expiration_date = transaction.credit_card_expiration_date
    @result = transaction.result
    @invoice_id = transaction.invoice_id
    create_list(:transaction, 5)
  end
  it "can search for an transaction with a query parameter" do
    get "/api/v1/transactions/find?id=#{@id}"
    transaction = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction["data"]["id"]).to eq(@id.to_s)

    get "/api/v1/transactions/find?credit_card_number=#{@credit_card_number}"
    transaction = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction["data"]["attributes"]["credit_card_number"]).to eq(@credit_card_number)

    get "/api/v1/transactions/find?credit_card_expiration_date=#{@credit_card_expiration_date}"
    transaction = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction["data"]["id"]).to eq(@id.to_s)

    get "/api/v1/transactions/find?result=#{@result}"
    transaction = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction["data"]["attributes"]["result"]).to eq(@result)

    get "/api/v1/transactions/find?invoice_id=#{@invoice_id}"
    transaction = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction["data"]["attributes"]["invoice_id"]).to eq(@invoice_id)

    get "/api/v1/transactions/find?created_at=#{@date}"
    transaction = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction["data"]["id"]).to eq(@id.to_s)

    get "/api/v1/transactions/find?updated_at=#{@date}"
    transaction = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction["data"]["id"]).to eq(@id.to_s)
  end

  it "can search for all transactions matching a query parameter" do
    create(:transaction, credit_card_number: '1', credit_card_expiration_date: '1', result: 'result', invoice_id: @invoice_id, created_at: @date, updated_at: @date)

    get "/api/v1/transactions/find_all?id=#{@id}"
    transactions = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transactions["data"].count).to eq(1)
    expect(transactions["data"].first["id"]).to eq(@id.to_s)

    get "/api/v1/transactions/find_all?credit_card_number=#{@credit_card_number}"
    transactions = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transactions["data"].count).to eq(2)
    expect(transactions["data"].first["attributes"]["credit_card_number"]).to eq(@credit_card_number)

    get "/api/v1/transactions/find_all?credit_card_expiration_date=#{@credit_card_expiration_date}"
    transactions = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transactions["data"].count).to eq(2)
    expect(transactions["data"].first["id"]).to eq(@id.to_s)

    get "/api/v1/transactions/find_all?result=#{@result}"
    transactions = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transactions["data"].count).to eq(2)
    expect(transactions["data"].first["attributes"]["result"]).to eq(@result)

    get "/api/v1/transactions/find_all?invoice_id=#{@invoice_id}"
    transactions = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transactions["data"].count).to eq(2)
    expect(transactions["data"].first["attributes"]["invoice_id"]).to eq(@invoice_id)

    get "/api/v1/transactions/find_all?created_at=#{@date}"
    transactions = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transactions["data"].count).to eq(2)
    expect(transactions["data"].first["id"]).to eq(@id.to_s)

    get "/api/v1/transactions/find_all?updated_at=#{@date}"
    transactions = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transactions["data"].count).to eq(2)
    expect(transactions["data"].first["id"]).to eq(@id.to_s)
  end

  it 'can return a random transaction' do
    create_list(:transaction, 10)

    ids = Transaction.all.map(&:id)

    get "/api/v1/transactions/random.json"


    transaction = JSON.parse(response.body)

    expect(response).to be_successful
    expect(ids).to include(transaction["data"]["id"].to_i)
  end
end
