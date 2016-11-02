class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  
  # using 'after_save' callback
  # it will return 'update_post' method everytime a 'vote' is saved
  after_save :update_post
  
  # the inclusion validation , to ensurese that value is assigned either a -1 or 1 when user vote
  validates :value, inclusion: { in: [-1, 1], message: "%{value} is not a valid vote." }, presence: true

  private
  
  # callback a method named 'update_rank' on a vote's post object
  def update_post
    post.update_rank
  end
  
end