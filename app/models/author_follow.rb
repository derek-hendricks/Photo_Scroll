class AuthorFollow < ActiveRecord::Base
	belongs_to :follow, :class_name => "Author"
	belongs_to :author
end

# the follow relationship is a belongs_to relationship because a row in the author_follows
# table will belong to a single follow author in the authors table. the relationship goes
# from AuthorFollow model to auther being followed

# belongs_to author relationship goes from AuthorFollow model to the author who is doing the following