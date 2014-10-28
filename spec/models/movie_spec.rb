require 'spec_helper'
require 'rails_helper'

describe Movie do
  describe 'searching TMDb by keyword' do

    it 'should call TMDb with title keywords' do
      expect(Tmdb::Movie).to receive(:find).with("Inception")
      Movie.find_in_tmdb("Inception")
    end
  end
  
  describe 'create movie from TMDb' do
  	
  	it 'should retrieve details from TMDb gem' do
  	  expect(Tmdb::Movie).to receive(:detail).with('941')
  	  Movie.create_from_tmdb('941')
    end 
    
    it 'should create a new Movie entry with the title, rating, release date, and description' do
    	expect(Movie).to receive(:create!).with(:title => 'Lethal Weapon', :rating => 'R', :release_date => '1987-03-05', :description => "Veteran buttoned-down LAPD detective Roger Murtaugh is partnered with unhinged cop Martin Riggs, who -- distraught after his wife's death -- has a death wish and takes unnecessary risks with criminals at every turn. The odd couple embark on their first homicide investigation as partners, involving a young woman known to Murtaugh with ties to a drug and prostitution ring.") #Lethal Weapon Data
    	Movie.create_from_tmdb('941')
    end
  end
end
