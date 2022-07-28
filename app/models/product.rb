class Product < ApplicationRecord
  belongs_to :category
  belongs_to :measure
  has_one_attached :image
  scope :by_name, -> (name){where('name LIKE ?',"%#{name}%")}

  def image_url
    Rails.application.routes.url_helpers.url_for(image) if image.attached?
  end

  validates :name, presence: true
  validates :stock, presence: true
  validates :value, presence: true
  validates :highlight, presence: true
  validates :image, presence: true
  validates :details, presence: true
end
