class CreateVotesTable < ActiveRecord::Migration
  def change
    create_table :votes, :id => false do |t|
      t.integer :vote_user_id 
    	t.integer :comment_id
    end
  end
end

