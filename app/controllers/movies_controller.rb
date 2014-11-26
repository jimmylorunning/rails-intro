#require 'debugger'

class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    forget = params.nil? ? false : params[:forget] == "true"
    session.clear if forget

    # make sure the data coming in is in right format or nil if not present
    session_ratings = (session[:rpsession].nil? || session[:rpsession][:ratings].nil?) ? nil : session[:rpsession][:ratings]
    session_sort = (session[:rpsession].nil? || session[:rpsession][:sort].nil?) ? nil : session[:rpsession][:sort]
    param_ratings = params.nil? ? nil : Movie.selected_ratings(params[:ratings])
    param_sort = params.nil? ? nil : params[:sort]

    # ratings is not specified in either session or params
    if (session_ratings.nil? && param_ratings.nil?)
      redirect_hash = {controller: 'movies', action: 'index', ratings: Movie.all_ratings_hash}
      redirect_hash[:sort] = (param_sort || session_sort)
      session[:rpsession] = {}
      flash.keep
      redirect_to redirect_hash
    elsif (param_ratings)  # ratings specified in params
      session[:rpsession][:ratings] = param_ratings
      session[:rpsession][:sort] = param_sort if !param_sort.nil?
    else # ratings remembered from session
      redirect_hash = {controller: 'movies', action: 'index', ratings: Movie.ratings_array_to_hash(session_ratings)}
      redirect_hash[:sort] = (param_sort || session_sort)
      flash.keep
      redirect_to redirect_hash
    end

    # question: when session is empty, do we want to redirect to ratings=all checked? or just leave URI as /movies
    # but render all boxes checked?

    @movies = Movie.find_all(session[:rpsession][:sort], session[:rpsession][:ratings])
    @current_sort = session[:rpsession][:sort]
    @ratings = session[:rpsession][:ratings]
    @all_ratings = Movie.all_ratings
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
