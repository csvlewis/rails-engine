FactoryBot.define do
  factory :item do
    merchant
    name { "Item" }
    description { "Item Description" }
    unit_price { 10000 }
  end
end
