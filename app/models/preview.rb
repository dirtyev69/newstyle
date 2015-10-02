class Preview < ActiveRecord::Base

  attr_accessible :painting_id, :asset, :remote_asset_url

  belongs_to :painting

  mount_uploader :asset, Preview::ImageUploader
end
