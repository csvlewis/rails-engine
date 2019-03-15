class Api::V1::Merchants::MerchantDateRevenueController < ApplicationController
  def show
    render json: RevenueSerializer.new(Merchant.find(params[:merchant_id]).total_date_revenue(params[:date]))
  end
end
