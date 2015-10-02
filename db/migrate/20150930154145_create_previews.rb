class CreatePreviews < ActiveRecord::Migration
  def change
    create_table :previews do |t|
      t.integer :painting_id
      t.string :asset
      t.timestamps
    end
  end
end

