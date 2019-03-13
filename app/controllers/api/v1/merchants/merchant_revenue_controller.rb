class Api::V1::Merchants::MerchantRevenueController < ApplicationController
  def show
    render json: Merchant.find(params["merchant_id"]).total_revenue
  end
end
