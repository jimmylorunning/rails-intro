require 'debugger'

class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    session_ratings = (session[:rpsession].nil? || session[:rpsession][:ratings].nil?) ? nil : session[:rpsession][:ratings]
    session_sort = (session[:rpsession].nil? || session[:rpsession][:sort].nil?) ? nil : session[:rpsession][:sort]
    param_ratings = params.nil? ? nil : Movie.selected_ratings(params[:ratings])
    param_sort = params.nil? ? nil : params[:sort]
#    debugger

    if (session_ratings.nil? && param_ratings.nil?)
      redirect_hash = {controller: 'movies', action: 'index', ratings: Movie.all_ratings_hash}
      redirect_hash[:sort] = (param_sort || session_sort)
      redirect_to redirect_hash
    elsif (param_ratings)
      session[:rpsession][:ratings] = param_ratings
      session[:rpsession][:sort] = param_sort
    else
      redirect_hash = {controller: 'movies', action: 'index', ratings: Movie.ratings_array_to_hash(session_ratings)}
      redirect_hash[:sort] = (param_sort || session_sort)
      redirect_to redirect_hash
    end

# so WHENEVER ratings is not specified in either session or params
# i.e. if (sessions.nil? || sessions[r].nil?) && (params.nil? || params[r].nil?)
  # sort = calc_sort()
  # redirect to index?ratings=all&sort b/c ratings not set...
# otherwise: ratings is set somewhere, so if !params[r].nil?
  # set session[r&s] = params[r&s]
  # render page
# otherwise: ratings is set in session, but not in params, URI needs to be updated
  # sort = calc_sort()
  # redirect to index?ratings=session[r]&sort

# write a function that calculates sort
# def calc_sort()
  # if params[:sort] exists, sort = params[:sort]
  # elsif session[:sort] exists, sort = session[:sort]
  # else no sort
# end


    # to do: change the rest of these variables to work with session instead of params

    @movies = Movie.find_all(session[:rpsession][:sort], session[:rpsession][:ratings])
#    @movies = Movie.show_all params[:sort]
    @current_sort = session[:rpsession][:sort]
    @ratings = session[:rpsession][:ratings]
    @all_ratings = Movie.all_ratings
    @s = session[:rpsession] # for debug purposes, remove later
  end

  def new
    # default: render 'new' template
      redirect_to :controller => 'movies',
        :action => 'index',
        :sort => session[:rpsession][:sort],
        :ratings => Movie.all_ratings_hash
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
