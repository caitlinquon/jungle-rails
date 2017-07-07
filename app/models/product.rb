class Product < ActiveRecord::Base

  monetize :price_cents, numericality: true
  mount_uploader :image, ProductImageUploader

  belongs_to :category
  has_many :reviews

  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
  validates :category, presence: true

  def average_rating
    if reviews.count > 0
      # reviews.all.sum('rating') / reviews.count
      reviews.sum('rating') / reviews.count
    else 
      0
    end 
  end 

  def sold_out?
    quantity == 0
  end

end
