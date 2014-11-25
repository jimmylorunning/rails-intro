class Movie < ActiveRecord::Base
  attr_accessible :title, :rating, :description, :release_date

  def self.show_all(sort)
    if (sort)
      return all order: "#{sort} ASC"
    else
      return all
    end
  end
=begin
  def self.find_all(sort, ratings)
  	if (sort)
  		ratings.each do |rk, rv|
  			x = find(:all, :conditions => ["rating = ?"])
  			x = find()

  	else
  		return all
  	end
  end
=end

  def self.all_ratings
  	return ['G', 'PG','PG-13', 'R']
  end

end
