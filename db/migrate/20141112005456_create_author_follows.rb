class CreateAuthorFollows < ActiveRecord::Migration
  def change
    create_table :author_follows do |t|
      t.integer :author_id
      t.integer :follow_id

      t.timestamps
    end
  end
end
