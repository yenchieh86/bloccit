class CreateComments < ActiveRecord::Migration
  def change
    
    # the 'create_table' takes a 'Symbol argument', which represents the table's name
    # 'create_table' also takes a block argument which contains the information that need to add into the table
    create_table :comments do |t|
      t.text :body
      
      # the 'index' to search by 'post_id'
      # this is a good idea for foreign key and is automatically added when we use "rails generate model Comment body:text post:references" to generate with 'references' argument
      # Foreign Key is the 'ID' of a model, each model has different uniquely ID
      t.references :post, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
