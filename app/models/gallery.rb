class Gallery < ActiveRecord::Base
  attr_accessible :name, :show_on_main
  has_many :paintings

  scope :show_on_main, -> { where(show_on_main: true) }

end
