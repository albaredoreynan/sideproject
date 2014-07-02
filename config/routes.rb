Case2::Application.routes.draw do
  devise_for :users
  
  namespace :account do
    resources :users 
  end

  resources :clients
  resources :lawyers
  resources :file_matters do
    collection do 
      get "autocomplete_file_matter_file_code"
      get "autocomplete_file_matter_title"
    end
  end
  resources :case_entries do
  	# get :autocomplete_file_matter_file_code, :on => :collection
    collection do 
      get "autocomplete_file_matter_file_code"
      get "autocomplete_file_matter_case_number"
    end
      
  end

  resources :admin_side
  resources :graphs
  
  root :to => 'case_entries#new'
  
  # ajax
  get 'pages/update_songs', :as => 'update_songs'
  get 'pages/update_songs2', :as => 'update_songs2'

  # search
  # match '/all_employees_list', :to => 'labor_hours#all_employees_list'
  match 'search_entry', :to  => 'case_entries#search_entry'
  match 'exclude_billing', :to =>  'case_entries#exclude_billing'
  match 'case_entries/search' => 'case_entries#search_entry'
  match 'file_matters/search' => 'file_matters#search_entry'
  match '/admin_side/search' => 'admin_side#index'
  
end
