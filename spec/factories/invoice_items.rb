FactoryBot.define do
  factory :invoice_item do
    item
    invoice
    quantity { 10 }
    unit_price { 10000 }
  end
end
