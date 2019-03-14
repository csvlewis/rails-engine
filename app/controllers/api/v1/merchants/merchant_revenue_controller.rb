class Api::V1::Merchants::MerchantRevenueController < ApplicationController
  def show
    render json: RevenueSerializer.new(Merchant.find(params["merchant_id"]).total_revenue)
  end
end
