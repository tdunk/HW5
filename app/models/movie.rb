class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 R)
  end
  
  def self.find_in_tmdb(params)
    Tmdb::Movie.find(params[:movie][:title])
  end
  
  def self.create_from_tmdb(movie_id)
  	movie = Tmdb::Movie.detail(movie_id)
  	self.create!(:title => movie.title, :rating => "R", :release_date => movie.release_date, :description => movie.overview)
  end
  
end
