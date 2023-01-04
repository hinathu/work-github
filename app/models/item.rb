class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :genre
  has_many :cart_item, dependent: :destroy
  has_many :order_details, dependent: :destroy

  validates :name, presence: true
	validates :introduction, presence: true
	validates :price, presence: true

  def get_image
    if image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    else
      image
    end
  end

  def add_tax_price
    (price * 1.10).round
  end

end
