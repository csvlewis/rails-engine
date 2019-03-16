class Api::V1::Customers::CustomersRandomController < ApplicationController
  def show
    render json: CustomerSerializer.new(Customer.all.sample)
  end
end
