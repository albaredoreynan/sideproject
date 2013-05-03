Case2::Application.routes.draw do
  devise_for :users

  resources :clients
  resources :lawyers
  resources :file_matters
  resources :case_entries do
  	get :autocomplete_file_matter_file_code, :on => :collection
  end
  
  root :to => 'case_entries#new'
  # ajax
  get 'pages/update_songs', :as => 'update_songs'

end
