class AddIndexesToUsers < ActiveRecord::Migration
  def change
    add_index :users, :uid
    add_index :users, :provider
    add_index :users, [:uid, :provider], unique: true
  end
end
