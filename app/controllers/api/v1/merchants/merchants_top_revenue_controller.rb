class Api::V1::Merchants::MerchantsTopRevenueController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.most_revenue(params[:quantity]))
  end
end
