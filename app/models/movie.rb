class Movie < ActiveRecord::Base
  attr_accessible :title, :rating, :description, :release_date

=begin
  def self.show_all(sort)
    if (sort)
      return all order: "#{sort} ASC"
    else
      return all
    end
  end
=end

  def self.find_all(sort, ratings)
  	find_hash = {:conditions => {:rating => (selected_ratings(ratings)||all_ratings)}}
  	if (sort)
  		find_hash[:order] = "#{sort} ASC"
  	end
  	return find(:all, find_hash)
  end

  def self.all_ratings
  	return ['G', 'PG','PG-13', 'R']
  end

  private
  	def self.selected_ratings(ratings)
  		return nil if ratings.nil?
  		ratings.select do |rating,value|
  			value == "true"
  		end.keys
  	end

end
