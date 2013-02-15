class Item
  include Mongoid::Document
  field :sku, type: String
  field :qty, type: Integer
  field :price, type: Integer
  embedded_in :order
end
