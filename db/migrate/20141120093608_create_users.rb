class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :avatar_url
      t.string :provider
      t.string :profile_url
      t.string :uid
      t.timestamps

    end
  end
end
