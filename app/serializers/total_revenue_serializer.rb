class TotalRevenueSerializer
  include FastJsonapi::ObjectSerializer
  attribute :total_revenue do |object|
    object.revenue.to_s.insert(-3, '.')
  end
end
