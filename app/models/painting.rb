class Painting < ActiveRecord::Base

  include PgSearch
  pg_search_scope :search, :against => :name, :using => { :tsearch => {:prefix => true} }

  paginates_per 25
  attr_accessible :gallery_id, :name, :price, :image, :remote_image_url, :item_type, :privews_attributes
  belongs_to :gallery
  has_many :previews

  mount_uploader :image, Painting::ImageUploader

  scope :ordered, -> { order("item_type ASC") }

  scope :newest_first, -> { order("created_at DESC") }

  MODEL_TYPES = {
    "Туфли" => 1,
    "Босоножки" => 2,
    "Шлепанцы" => 3,
    "Сапоги" => 4,
    "Полусапожки" => 5,
    "Ботильоны" => 6,
    "Ботинки" => 7,
    "Сумки" => 8
  }

  def self.text_search(query)
    if query.present?
      search(query)
    end
  end
end
