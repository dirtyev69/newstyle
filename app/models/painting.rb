class Painting < ActiveRecord::Base
  paginates_per 25
  attr_accessible :gallery_id, :name, :price, :image, :remote_image_url, :item_type, :privews_attributes
  belongs_to :gallery
  has_many :previews

  mount_uploader :image, Painting::ImageUploader

  scope :ordered, -> { order("item_type ASC") }

  scope :newest_first, -> { order("created_at DESC") }
end
