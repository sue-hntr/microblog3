class CreatePostsTable < ActiveRecord::Migration
  def change
  	  	create_table	:posts do |b|
  		b.string	:title
  		b.text		:body
  		b.integer	:user_id
  end
  end
end
