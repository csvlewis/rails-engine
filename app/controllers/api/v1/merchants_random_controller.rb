class Api::V1::MerchantsRandomController < ApplicationController
  def show
    render json: Merchant.all.sample
  end
end
