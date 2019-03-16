class Api::V1::Merchants::MerchantFavoriteCustomerController < ApplicationController
  def show
    render json: CustomerSerializer.new(Merchant.find(params[:merchant_id]).favorite_customer.first)
  end
end
