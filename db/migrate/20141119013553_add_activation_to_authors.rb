class AddActivationToAuthors < ActiveRecord::Migration
  def change
    add_column :authors, :activation_digest, :string
    add_column :authors, :activated, :boolean, default: false
    add_column :authors, :activated_at, :datetime
  end
end
