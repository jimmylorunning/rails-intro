class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    s = SessionsHelper.new(session)
    s.forget if params.nil? ? false : params[:forget] == '1'

    param = {}
    param[:ratings] = params.nil? ? nil : Movie.valid_ratings(params_to_array(params[:ratings]))
    param[:sort] = params.nil? ? nil : params[:sort]

    # REDIRECT in either of these cases:
    # 1. ratings is not specified in either session or params
    if (s._ratings.nil? && param[:ratings].nil?)
      flash.keep
      redirect_to controller: 'movies', action: 'index',
        ratings: to_params_hash(Movie.all_ratings),
        sort: (param[:sort] || s._sort)
    elsif (!param[:ratings]) # 2. ratings not specified in params, but remembered from session
      flash.keep
      redirect_to controller: 'movies', action: 'index',
        ratings: to_params_hash(Movie.valid_ratings(s._ratings)),
        sort: (param[:sort] || s._sort)
    end

    s._ratings = param[:ratings]
    s._sort = param[:sort] if !param[:sort].nil?
    @movies = Movie.find_all(s._sort, s._ratings)
    @current_sort = s._sort
    @current_ratings = s._ratings
    @all_ratings = Movie.all_ratings
  end

  def new
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end