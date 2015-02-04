require 'time'
require 'date'

class Link < ActiveRecord::Base
	validates :url, :presence => true
 
	has_many :comments, :as => :commentable

	#default_scope { order('upvotes DESC') } #if just wanted to order by upvotes, would use this. Here, though, I order by a formula combining upvotes and dates (so most popular don't stay forever at top)

  before_save :put_in_http #so that link has http:// affixed.  Could also, in index, just put: <a href="http://<%=link.url%>"><%= link.url %> </a>  


  def rating_formula
    time = Time.new
    age = ((time - self.created_at)/60/60/24).to_i
    if upvotes != nil
       rating = upvotes + age * (-0.5)
    else 
        rating = age * (-0.5)
    end
    rating
  end

  def self.order_by_rating_formula
    links = Link.all
    links_ordered_by_ratings = {}
    links.each do |link|
      links_ordered_by_ratings[link] = link.rating_formula
    end
    updated_order = links_ordered_by_ratings.keys.sort {|a, b| links_ordered_by_ratings[b] <=> links_ordered_by_ratings[a]}
  end

  def age
    time = Time.new
    age = time - self.created_at #created at added by timestamps column

    result = ''
    if age < (60*60)
      result = "#{(age/60).to_i} minutes"
    elsif age < (60*60*24)
      result = "#{(age/60/60).to_i} hours"
    else
      result = "#{(age/60/60/24).to_i} days"
    end
    result
  end

  private

  def put_in_http
    regex = /http/
    unless self.url.match(regex)
      self.url = "http://#{self.url}"
    end
  end

end

#NOTE: Alternative method of updating upvotes:
#1) in model: 
  #def add_upvote
     #current_votes = self.upvotes.to_i
     #total_with_additional_vote = (current_votes + 1)
     #self.update({:upvotes => total_with_additional_vote })
  #end

#2) in index view:
	#<%= link_to "↑", link_path(link), :method => :patch %>

#3) in link controller:
  #def update 
    #@link = Link.find(params[:id])
    #@link.add_upvote
    #redirect_to root_path
  #end

