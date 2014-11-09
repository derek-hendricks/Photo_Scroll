class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :caption
      t.text :description
      t.string :url
      t.integer :rating

      t.timestamps
    end
  end
end
