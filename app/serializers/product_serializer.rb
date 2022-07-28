class ProductSerializer < ActiveModel::Serializer
  belongs_to :category
  belongs_to :measure
  
  attributes :id, :name, :details, :stock, :value, :highlight, :category_id, :measure_id, :image_url
end
