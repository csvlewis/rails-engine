class Api::V1::Merchants::MerchantDateRevenueController < ApplicationController
  def show
    render json: RevenueSerializer.new(Merchant.find(params[:merchant_id]).date_revenue(params[:date]))
  end
end
