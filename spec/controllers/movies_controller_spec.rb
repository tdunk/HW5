require 'spec_helper'
require 'rails_helper'

describe MoviesController do
  describe 'searching TMDb' do
    it 'should call the model method that performs TMDb search' do
      Movie = double(Movie)
      fake_results = [double('movie1'),double('movie2')]
      expect(Movie).to receive(:find_in_tmdb).with('Ted').and_return(fake_results)
      post :search_tmdb, {:movie => {:title => 'Ted'}}
    end
    
    it 'should select the Search Results template for rendering' do
      Movie = double(Movie)
      fake_results = [double('movie1'),double('movie2')]
      allow(Movie).to receive(:find_in_tmdb).and_return(fake_results)
      post :search_tmdb, {:movie => {:title => 'Ted'}}
      expect(response).to render_template('search_tmdb')
    end
    
    it 'should make the TMDb search results available to that template' do
      Movie = double(Movie)
      fake_results = [double('movie1'),double('movie2')]
      allow(Movie).to receive(:find_in_tmdb).and_return(fake_results)
      post :search_tmdb, {:movie => {:title => 'Ted'}}
      expect(assigns(:matching_movies)).to eq fake_results
    end
    
    it 'should check for invalid search terms and redirect to home page' do
      post :search_tmdb, {:movie => {:title => ''}}
      expect(response).to redirect_to(movies_path)
    end
    
    it 'should check if no movies are found and redirect to home page' do
      Movie = double(Movie)
      expect(Movie).to receive(:find_in_tmdb).with('asdj').and_return([])
      post :search_tmdb, {:movie => {:title => 'asdj'}}
      expect(response).to redirect_to(movies_path)
    end
    
    it 'should flash No mathcing movies were found on TMDb when no movies are found' do
      Movie = double(Movie)
      expect(Movie).to receive(:find_in_tmdb).with('asdj').and_return([])
      post :search_tmdb, {:movie => {:title => 'asdj'}}
      expect(flash[:notice]).to eq 'No mathcing movies were found on TMDb'
    end
    
    it 'should flash Invalid search term when search term is empty' do
      post :search_tmdb, {:movie => {:title => ''}}
      expect(flash[:notice]).to eq 'Invalid search term'
    end
    
    it 'should return an array of movie hashes with keys tmdb_id, title, rating, and release_date'

    it 'should pass two parameters to the view'
    
  end
  
  describe 'add a movie from TMDb' do
  	
  	it 'should receive a params hash of a hash with keys of movies selected'
  	
  	it 'should call create_from_tmdb for each movie'
  
  end
  
end
