Case2::Application.routes.draw do
  devise_for :users

  resources :clients
  resources :lawyers
  resources :file_matters
  resources :case_entries do
  	get :autocomplete_file_matter_file_code, :on => :collection
  end

  resources :admin_side
  
  root :to => 'case_entries#new'
  
  # ajax
  get 'pages/update_songs', :as => 'update_songs'
  get 'pages/update_songs2', :as => 'update_songs2'

  # search
  match '/admin_side/search' => 'case_entries#index'
  match '/case_entries/searching' => 'case_entries#searching'
  
end
