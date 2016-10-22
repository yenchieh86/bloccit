require 'random_data'

1.times do
   Post.find_or_create_by(
       title: "HiYen",
       body: "HIHIYen"
       )
end

# create Posts
50.times do
    # add a '!' after '.create' let program to raise an error if there's a problem with the data we're seeding
    # if use '.create' without the '!', it won't raise an error when program fails
    Post.create!(
        # at this moment, the 'RandomData' method is not exist yet, so it will create some random strings for 'title' and 'body'
        # it will increase productivity if we are writing code for classes and methods that don't exist
        # writing code for the class and method that don't exist can help us to stay fouchsed on one problem at a time
        # so the process will be: 'use a not existed method to write code' >> 'create a file and statement for that methoed'
        title: RandomData.random_sentence,
        body: RandomData.random_paragraph
        )
end



posts = Post.all

1.times do
   Comment.find_or_create_by(
       post: posts[1],
       body: "hihihi"
   )
end

# create Comments
# use '.times' on an 'Inteer'(a number object)
# '.times' will loop codes (in the given block) 100 times
100.times do
   Comment.create!(
       # use '.sample'(Ruby method) to pick a random post element in the array athat returned by 'Post.all'
       post: posts.sample,
       body: RandomData.random_paragraph
       ) 
end

50.times { Advertisement.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, price: rand(0..50))}


puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
puts "#{Advertisement.count} advertisements created"