require 'rails_helper'

describe "Customers API" do
  before :each do
    @date = '2019-03-12 19:31:18 UTC'
    customer = create(:customer, first_name: 'John', last_name: 'Doe', created_at: @date, updated_at: @date)
    @id = customer.id
    @first_name = customer.first_name
    @last_name = customer.last_name
  end
  it 'can search for a customer with a query parameter' do
    get "/api/v1/customers/find?id=#{@id}"
    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["data"]["id"]).to eq(@id.to_s)

    get "/api/v1/customers/find?first_name=#{@first_name}"
    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["data"]["attributes"]["first_name"]).to eq(@first_name)

    get "/api/v1/customers/find?last_name=#{@last_name}"
    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["data"]["attributes"]["last_name"]).to eq(@last_name)

    get "/api/v1/customers/find?created_at=#{@date}"
    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["data"]["id"]).to eq(@id.to_s)

    get "/api/v1/customers/find?updated_at=#{@date}"
    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["data"]["id"]).to eq(@id.to_s)
  end

  it 'can search for all customers matching a query parameter' do
    create(:customer, first_name: 'John', last_name: 'Doe', created_at: @date, updated_at: @date)

    get "/api/v1/customers/find_all?id=#{@id}"
    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer.count).to eq(1)
    expect(customer["data"].first["id"]).to eq(@id.to_s)

    get "/api/v1/customers/find_all?first_name=#{@first_name}"
    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["data"].count).to eq(2)
    expect(customer["data"].first["attributes"]["first_name"]).to eq(@first_name)

    get "/api/v1/customers/find_all?last_name=#{@last_name}"
    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["data"].count).to eq(2)
    expect(customer["data"].first["attributes"]["last_name"]).to eq(@last_name)

    get "/api/v1/customers/find_all?created_at=#{@date}"
    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["data"].count).to eq(2)
    expect(customer["data"].first["id"]).to eq(@id.to_s)

    get "/api/v1/customers/find_all?updated_at=#{@date}"
    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["data"].count).to eq(2)
    expect(customer["data"].first["id"]).to eq(@id.to_s)
  end

  it "can search for a random customer" do
    create_list(:customer, 10)

    ids = Customer.all.map(&:id)

    get "/api/v1/customers/random.json"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(ids).to include(customer["data"]["id"].to_i)
  end
end
