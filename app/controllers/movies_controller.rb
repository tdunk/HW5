class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    sort = params[:sort] || session[:sort]
    case sort
    when 'title'
      ordering,@title_header = {:order => :title}, 'hilite'
    when 'release_date'
      ordering,@date_header = {:order => :release_date}, 'hilite'
    end
    @all_ratings = Movie.all_ratings
    @selected_ratings = params[:ratings] || session[:ratings] || {}
    
    if @selected_ratings == {}
      @selected_ratings = Hash[@all_ratings.map {|rating| [rating, rating]}]
    end
    
    if params[:sort] != session[:sort] or params[:ratings] != session[:ratings]
      session[:sort] = sort
      session[:ratings] = @selected_ratings
      redirect_to :sort => sort, :ratings => @selected_ratings and return
    end
    @movies = Movie.find_all_by_rating(@selected_ratings.keys, ordering)
  end

  def new
    # default: render 'new' template
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
  
  def search_tmdb
    if params[:movie][:title] == ''
      flash[:notice] = 'Invalid search term'
      redirect_to movies_path
    else
      Tmdb::Api.key('f4702b08c0ac6ea5b51425788bb26562')
      @matching_movies = Movie.find_in_tmdb(params[:movie][:title])
      if @matching_movies.count == 0
        flash[:notice] = 'No mathcing movies were found on TMDb'
        redirect_to movies_path
      end
    end    
  end
  
  def add_tmdb
    if params[:tmdb_movies] == nil
      flash[:notice] = 'No movies selected'
    else
		  params[:tmdb_movies].keys.each do |movie|
		    Movie.create_from_tmdb movie
		  end 
		  flash[:notice] = 'Movies successfully added to Rotten Potatoes' 
		end
    redirect_to movies_path
  end
end
