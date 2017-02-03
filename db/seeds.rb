require 'random_data'

admin = User.create!(
    name: "Yen Chen",
    email: "yenchieh86@hotmail.com",
    password: "jack4930",
    role: "admin"
)

5.times do
  User.create!(
    name: RandomData.random_name,
    email: RandomData.random_email,
    password: RandomData.random_sentence
  )
end

users = User.all

15.times do
    Topic.create!(
        name: RandomData.random_sentence,
        description: RandomData.random_paragraph
    )
end

topics = Topic.all

Post.find_or_create_by(
    user: users.sample,
    topic: topics.sample,
    title: "HiYen",
    body: "HIHIYen"
    )

50.times do
    post = Post.create!(
        user: users.sample,
        topic: topics.sample,
        title: RandomData.random_sentence,
        body: RandomData.random_paragraph
        )

    post.update_attribute(:created_at, rand(10.minutes .. 1.year).ago)
    rand(1..5).times { post.votes.create!(value: [-1, 1].sample, user: users.sample) }
end

posts = Post.all

Comment.find_or_create_by(
    post: posts[1],
    body: "hihihi"
)

100.times do
   Comment.create!(
       user: users.sample,
       post: posts.sample,
       body: RandomData.random_paragraph
       ) 
end

member = User.create!(
    name: "member Chen",
    email: "member@hotmail.com",
    password: "jack4930",
    role: "member"
)

50.times { Advertisement.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, price: rand(0..50))}
50.times { Question.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, resolved: (rand(1..3) > 2))}
50.times { Sponsoredpost.create!(topic: topics.sample, title: RandomData.random_sentence, body: RandomData.random_paragraph, price: rand(0..50))}

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Topic.count} topics creates"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
puts "#{Vote.count} votes created"
puts "#{Advertisement.count} advertisements created"
puts "#{Question.count} questions created"
puts "#{Sponsoredpost.count} Sponsoredpost created"