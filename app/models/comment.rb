class Comment < ActiveRecord::Base
	validates :comment, :presence => true
 
	belongs_to :commentable, :polymorphic => true  #"commentable" tells "Comment" what it is associated with in terms of polymorphic association
    has_many :comments, :as => :commentable   #can add comment to comments by: comment.comments.create(comment: ...)
  
  def find_original_link
    parent = self.commentable #this finds the parent of an attribute in a polymorphic association
    until parent.class == Link
      parent = parent.commentable
    end
    parent
  end

end