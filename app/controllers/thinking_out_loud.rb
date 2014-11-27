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


#    if params[:ratings].nil?
#      flash.keep
#     redirect_to(movies_path({sort: session[:rpsession][:sort], ratings: session[:rpsession][:ratings]}))
=begin
      redirect_to :controller => 'movies',
        :action => 'index',
        :sort => session[:rpsession][:sort],
        :ratings => Movie.all_ratings_hash
      # to do, add params to this path by reading it out of session
=end
#    end


    # if it's the first time visiting (no session set)
    # or if ratings are all unchecked




=begin
    if (params[:ratings].nil? && !session[:rpsession].nil? && !session[:rpsession][:ratings].nil?)
      # don't do anything, use existing session, don't reset session to params or to all
    elsif (session[:rpsession].nil? || session[:rpsession][:ratings].nil?)
      # set session to select ALL ratings
      session[:rpsession] = {ratings: Movie.all_ratings}
      session[:rpsession][:sort] = params[:sort] # set sort to params or nil
    else
      # set session to newly selected ratings (or same ones if not changed)
      session[:rpsession][:ratings] = Movie.selected_ratings params[:ratings]
      session[:rpsession][:sort] = params[:sort]
    end
=end

# scenario 1 - first time visitor, session = nil, params = nil
  # result - redirect to index?ratings=(all)
# scenario 2 - first time visitor, session = nil, params != nil (followed a link w/ params)
  # result - session[r&s] = params[r&s]
# scenario 3 - first time visitor, session = nil, p[r] = nil, p[s] != nil (followed a link w/ params)
  # result - redirect to index?ratings=(all)&sort=(p[s])

# scenario 4 - return visit, session != nil, params[r&s] = nil
  # result - redirect to index?ratings=(session[r])&sort=(session[s])
# scenario 5 - return visit, session != nil, p[r] = nil, p[s] != nil
  # result - redirect to index?ratings=(session[r])&sort=(p[s])
# scenario 6 - return visit, session != nil, p[r] != nil, p[s] = nil
  # result - session[r&s] = p[r&s]
# scenario 7 - return visit, session != nil, params[r&s] != nil
  # result - session[r&s] = p[r&s]

# what if return visit, session[r] = nil && session[s] != nil, params[r] = nil???
#  result - redirect to index?ratings=(all)

# scenario 8 - session != nil but session[r] = nil, p[r] = nil or p = nil
# could s8 happen?

# grouped by result:
# scenarios:
#  [[1],[3]] = ratings=(all) sort behavior different
#  [[4],[5]] = ratings=(session[r]) sort behavior different
#  [2,6,7] = s = p

# handle 2,6,7
# if !params.nil? && !params[r].nil?
#   result - session[r&s] = p[r&s]

# handle 4, 5
# elsif !session.nil? #  don't need this part because of previous if: && (params.nil? || (!params.nil? && params[r].nil))
#   sort = p[s] if p[s] else sort = session[s]
#   result - redirect to index?ratings=session[r]

# handle 1, 3
# if session.nil? && (params.nil? || params[r].nil?)
#   sort = p[s] if p[s]
#   result - redirect to index?ratings=(all)&sort


# ##########
# view can see params, so maybe we don't need @ratings to be set in controller
# use pluck instead of all_ratings?
# add testing