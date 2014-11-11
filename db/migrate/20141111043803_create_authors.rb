class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :full_name
      t.string :username
      t.string :password
      t.text :profile
      t.string :image

      t.timestamps
    end
  end
end
