require 'rails_helper'

describe "Customers API" do
  before :each do
    @id = create(:customer).id
    create_list(:customer, 2)
  end
  it "can return an index of customers" do

    get "/api/v1/customers.json"

    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers["data"].count).to eq(3)
  end

  it 'can return a customer by id' do
    get "/api/v1/customers/#{@id}.json"

    expect(response).to be_successful

    customer = JSON.parse(response.body)

    expect(customer["data"]["id"]).to eq(@id.to_s)
  end
end
