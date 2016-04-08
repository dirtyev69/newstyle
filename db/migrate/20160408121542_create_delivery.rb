class CreateDelivery < ActiveRecord::Migration
  def change
    create_table :deliveries do |t|
      t.string :email
      t.string :text
      t.timestamps
    end
  end
end
