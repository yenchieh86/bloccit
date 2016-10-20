# use 'rails generate model Post title:string body:text' to create this file
# this file called 'migration file'. The codes inside are wirtten in Ruby
# this file is a class named 'CreatePosts'

# when run the migration, the 'change' will call 'create_table', and 'create_table' will take the attribute that we want our table to have

# use 'rake db:migrate' to create 'schema.rb'
class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body

      t.timestamps null: false
    end
  end
end
