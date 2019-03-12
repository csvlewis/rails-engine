require 'rails_helper'

describe "Customers API" do
  it "can return an index of customers" do
    create_list(:customer, 3)

    get "/api/v1/customers.json"

    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers.count).to eq(3)
  end
end
