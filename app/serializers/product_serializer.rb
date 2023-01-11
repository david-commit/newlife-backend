class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :category, :price_in_2dp, :description, :image, :dosage, :stock

  has_many :dosage_considerations
  has_many :side_effects
  has_many :reviews

  def price_in_2dp
    #price in 2 decimal places
    #please note that we're only rounding up
    #for instance, 3.441 will be rounded to 3.45
    (self.object.price * 100).ceil/100.0
  end
end
