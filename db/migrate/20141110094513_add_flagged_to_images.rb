class AddFlaggedToImages < ActiveRecord::Migration
  def change
    add_column :images, :flagged, :boolean
  end
end
