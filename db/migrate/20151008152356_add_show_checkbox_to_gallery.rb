class AddShowCheckboxToGallery < ActiveRecord::Migration
  def change
    add_column :galleries, :show_on_main, :boolean, default: false, null: false
  end
end
