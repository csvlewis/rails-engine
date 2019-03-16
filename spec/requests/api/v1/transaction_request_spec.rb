require 'rails_helper'

describe "Transactions API" do
  before :each do
    @id = create(:transaction).id
    create_list(:transaction, 2)
  end
  it "can return an index of transactions" do

    get "/api/v1/transactions.json"

    expect(response).to be_successful

    transactions = JSON.parse(response.body)

    expect(transactions["data"].count).to eq(3)
  end

  it 'can return a transaction by id' do
    get "/api/v1/transactions/#{@id}.json"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)

    expect(transaction["data"]["id"]).to eq(@id.to_s)
  end
end
