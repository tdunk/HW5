class Movie < ActiveRecord::Base

  class Movie::InvalidKeyError < StandardError ; end
  
  def self.all_ratings
    %w(G PG PG-13 R)
  end
  
  def self.find_in_tmdb(movie_title)
    matching_movies = Array.new
    
      movies = Tmdb::Movie.find(movie_title)
      
      if(movies != nil)
        movies.each do |movie|
    
		    rating = 'PG-13'
		    Tmdb::Movie.releases(movie.id)[:countries].each do |country|
		      if(country[:iso_3166_1] == 'US')
		        rating = country[:certification]
		        break
		      end
		    end
		    matching_movies << {:tmdb_id => movie.id, :title => movie.title, :rating => rating, :release_date => movie.release_date}
		  end
    return matching_movies
    end
  end
  
  def self.create_from_tmdb(movie_id)
  	movie = Tmdb::Movie.detail(movie_id)
  	rating = ''
  	if movie != nil
			Tmdb::Movie.releases(movie.id)[:countries].each do |country|
		    if(country[:iso_3166_1] == 'US')
		      rating = country[:certification]
		      break
		    end
		  end
		  if rating == ''
		    rating = 'PG-13'
		  end
			self.create!(:title => movie.title, :rating => rating, :release_date => movie.release_date, :description => movie.overview)
		end
  end  
end
