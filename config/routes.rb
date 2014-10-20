Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  
  match '/movies/search_tmdb', :to => 'movies#search_tmdb', :via => :post
  match '/movies', :to => 'movies#add_tmdb', :via => :put
end
