class Api::V1::Merchants::MerchantsRandomController < ApplicationController
  def show
    render json: MerchantSerializer.new(Merchant.all.sample)
  end
end
