Case2::Application.routes.draw do
  devise_for :users

  resources :clients
  resources :lawyers
  resources :file_matters
  resources :case_entries do
  	# get :autocomplete_file_matter_file_code, :on => :collection
    collection do 
      get "autocomplete_file_matter_file_code"
      get "autocomplete_file_matter_case_number"
    end
      
  end

  resources :admin_side
  
  root :to => 'case_entries#new'
  
  # ajax
  get 'pages/update_songs', :as => 'update_songs'
  get 'pages/update_songs2', :as => 'update_songs2'

  # search
  # match '/all_employees_list', :to => 'labor_hours#all_employees_list'
  match 'search_entry', :to  => 'case_entries#search_entry'
  match 'case_entries/search' => 'case_entries#search_entry'
  match '/admin_side/search' => 'admin_side#index'
  
end
