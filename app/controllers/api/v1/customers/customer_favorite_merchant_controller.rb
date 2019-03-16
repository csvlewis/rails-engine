class Api::V1::Customers::CustomerFavoriteMerchantController < ApplicationController
  def show
    render json: MerchantSerializer.new(Customer.find(params[:customer_id]).favorite_merchant.first)
  end
end
