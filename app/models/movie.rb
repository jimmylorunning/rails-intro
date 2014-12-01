class Movie < ActiveRecord::Base
  attr_accessible :title, :rating, :description, :release_date

  CHECKED_VALUE = '1'

  def self.find_all(sort, ratings)
  	find_hash = {:conditions => {:rating => ratings||all_ratings}}
  	if valid_sort?(sort)
  		find_hash[:order] = "#{sort} ASC"
  	end
  	return find(:all, find_hash)
  end

  def self.all_ratings
  	return self.uniq.pluck(:rating)
  end

	# takes an array of ratings
	# returns only ratings within valid range
	def self.valid_ratings(ratings)
		return nil if ratings.nil?
		ratings.select do |rating|
			all_ratings.include? rating
		end
	end

	private
	  def self.valid_sort?(sort)
			 return false if !sort
			 ['title', 'release_date'].include? sort
	  end


end
