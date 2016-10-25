# use 'rails generate migration AddTopicToPosts topic_id:integer:index' to add this file
# this file to for adding a 'topic id foreign key attribute' to the posts table
class AddTopicToPosts < ActiveRecord::Migration
  def change
    # the name that we give to this file is to instruct the grnerator to create a migration that adds a topic_id column to the posts table
    add_column :posts, :topic_id, :integer
    # use generator to create an index on 'topic_id'
    # an index improves the speed of operations on a database table
    add_index :posts, :topic_id
  end
end
