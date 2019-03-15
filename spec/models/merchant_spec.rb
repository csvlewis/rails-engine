require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'relationships' do
    it { should have_many :invoices }
    it { should have_many :items }
  end

  describe 'instance methods' do
    before :each do
      @customer_1 = create(:customer)
      @customer_2 = create(:customer)
      @date = '2019-03-12 19:31:18 UTC'
      @assertion = '2019-03-12T19:31:18.000Z'
      @merchant = create(:merchant)
      @invoice = create(:invoice, merchant: @merchant, created_at: @date, updated_at: @date, customer_id: @customer_1.id)
      @invoice_2 = create(:invoice, merchant: @merchant, customer_id: @customer_1.id)
      @invoice_3 = create(:invoice, merchant: @merchant, customer_id: @customer_2.id)
      @invoice_4 = create(:invoice, merchant: @merchant, customer_id: @customer_2.id)
      create(:transaction, invoice: @invoice)
      create(:transaction, invoice: @invoice_2, result: 'failed')
      create(:transaction, invoice: @invoice_3)
      create(:transaction, invoice: @invoice_4)
      create_list(:invoice_item, 1, unit_price: 100, quantity: 5, invoice: @invoice)
      create_list(:invoice_item, 1, unit_price: 100, quantity: 5, invoice: @invoice_2)
      create_list(:invoice_item, 1, unit_price: 100, quantity: 5, invoice: @invoice_3)
      create_list(:invoice_item, 1, unit_price: 100, quantity: 5, invoice: @invoice_4)
      @id = @merchant.id
    end
    describe 'total_revenue' do
      it 'returns the total revenue for a merchant across successful transactions' do
        expect(@merchant.total_revenue[0].revenue).to eq(1500)
      end
    end

    describe 'total_date_revenue(date)' do
      it 'returns the total revenue for a merchant across successful transactions on a specific date' do
        expect(@merchant.total_date_revenue('2019-03-12')[0].revenue).to eq(500)
      end
    end

    describe 'favorite_customer' do
      it 'returns the customer who has conducted the most successful transactions with this merchant' do
        expect(@merchant.favorite_customer[0].id).to eq(@customer_2.id)
      end
    end
  end

  describe 'class methods' do
    before :each do
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
      @merchant_3 = create(:merchant)
      @merchant_4 = create(:merchant)
      date = '2019-03-12 19:31:18 UTC'
      invoice_1 = create(:invoice, merchant: @merchant_1, created_at: date, updated_at: date)
      invoice_2 = create(:invoice, merchant: @merchant_2)
      invoice_3 = create(:invoice, merchant: @merchant_3)
      invoice_4 = create(:invoice, merchant: @merchant_3)
      invoice_5 = create(:invoice, merchant: @merchant_4)
      create(:transaction, invoice: invoice_1)
      create(:transaction, invoice: invoice_2)
      create(:transaction, invoice: invoice_3)
      create(:transaction, invoice: invoice_4, result: 'failed')
      create(:transaction, invoice: invoice_5)
      create(:invoice_item, unit_price: 1000000, quantity: 2, invoice: invoice_1)
      create(:invoice_item, unit_price: 10000, quantity: 3, invoice: invoice_2)
      create(:invoice_item, unit_price: 100, quantity: 4, invoice: invoice_3)
      create(:invoice_item, unit_price: 100000000, quantity: 10, invoice: invoice_4)
      create(:invoice_item, unit_price: 1, quantity: 1, invoice: invoice_4)
    end
    describe '.most_revenue(x)' do
      it 'returns the top x merchants ranked by total revenue' do
        expect(Merchant.most_revenue(3)[0].id).to eq(@merchant_1.id)
        expect(Merchant.most_revenue(3)[1].id).to eq(@merchant_2.id)
        expect(Merchant.most_revenue(3)[2].id).to eq(@merchant_3.id)
      end
    end

    describe '.most_items(x)' do
      it 'returns the top x merchants ranked by total items sold' do
        expect(Merchant.most_items(3)[0].id).to eq(@merchant_3.id)
        expect(Merchant.most_items(3)[1].id).to eq(@merchant_2.id)
        expect(Merchant.most_items(3)[2].id).to eq(@merchant_1.id)
      end
    end
  end
end
