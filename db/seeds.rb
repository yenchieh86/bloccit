require 'random_data'

# create topics
15.times do
    Topic.create!(
        name: RandomData.random_sentence,
        description: RandomData.random_paragraph
    )
end

topics = Topic.all

Post.find_or_create_by(
    topic: topics.sample,
    title: "HiYen",
    body: "HIHIYen"
    )

# create Posts
50.times do
    # add a '!' after '.create' let program to raise an error if there's a problem with the data we're seeding
    # if use '.create' without the '!', it won't raise an error when program fails
    Post.create!(
        # at this moment, the 'RandomData' method is not exist yet, so it will create some random strings for 'title' and 'body'
        # it will increase productivity if we are writing code for classes and methods that don't exist
        # writing code for the class and method that don't exist can help us to stay fouchsed on one problem at a time
        # so the process will be: 'use a not existed method to write code' >> 'create a file and statement for that methoed'
        topic: topics.sample,
        title: RandomData.random_sentence,
        body: RandomData.random_paragraph
        )
end



posts = Post.all

Comment.find_or_create_by(
    post: posts[1],
    body: "hihihi"
)


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
50.times { Question.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, resolved: (rand(1..3) > 2))}
<<<<<<< HEAD
50.times { Sponsoredpost.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, price: rand(0..50))}
=======
50.times { Sponsoredpost.create!(topic: topics.sample, title: RandomData.random_sentence, body: RandomData.random_paragraph, price: rand(0..50))}
>>>>>>> cp22
# display informations
puts "Seed finished"
puts "#{Topic.count} topics creates"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
puts "#{Advertisement.count} advertisements created"
puts "#{Question.count} questions created"
puts "#{Sponsoredpost.count} Sponsoredpost created"