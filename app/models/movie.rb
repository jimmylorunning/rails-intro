class Movie < ActiveRecord::Base
  attr_accessible :title, :rating, :description, :release_date

  def self.find_all(sort, ratings)
  	find_hash = {:conditions => {:rating => ratings||all_ratings}}
  	if valid_sort?(sort)
  		find_hash[:order] = "#{sort} ASC"
  	end
  	return find(:all, find_hash)
  end

  def self.all_ratings
  	return ['G', 'PG','PG-13', 'R']
  end

	def self.selected_ratings(ratings)
		return nil if ratings.nil?
		ratings.select do |rating,value|
			((all_ratings.include? rating) && (value == "true"))
		end.keys
	end

	# convert ratings array (internal) to ratings hash (URI display)
	def self.ratings_array_to_hash(ratings_array)
		return nil if ratings_array.nil?
		ratings_hash = {}
		ratings_array.each do |rating|
			if (all_ratings.include? rating)
				ratings_hash[rating] = 'true'
			end
		end
		return ratings_hash
	end

	def self.all_ratings_hash
		return ratings_array_to_hash(all_ratings)
	end

	private
	  def self.valid_sort?(sort)
			 return false if !sort
			 ['title', 'release_date'].include? sort
	  end


end
