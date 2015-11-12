class AddPriceToPainting < ActiveRecord::Migration
  def change
    add_column :paintings, :price, :integer, :null => false, :default => 0
  end
end

