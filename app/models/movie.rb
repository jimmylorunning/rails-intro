class Movie < ActiveRecord::Base
  attr_accessible :title, :rating, :description, :release_date

  def Movie.show_all(sort)
    if (sort)
      return all order: "#{sort} ASC"
    else
      return all
    end
  end
end
