class InvoiceItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :quantity, :item_id, :invoice_id
  attribute :unit_price do |object|
    object.unit_price.to_s.insert(-3, '.')
  end
end
