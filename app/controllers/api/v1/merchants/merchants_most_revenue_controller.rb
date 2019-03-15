class Api::V1::Merchants::MerchantsMostRevenueController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.most_revenue(params[:quantity]))
  end
end
