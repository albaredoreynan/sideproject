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
  resources :graphs do 
    collection do 
      get "ac_file_code"
      get "ac_client_gr"
    end
  end
  resources :calls do
    collection do 
      get "ac_client"
    end
  end

  resources :printouts do
    collection do 
      get "ac_file_code"
    end

  end
  
  resources :notifications do
    collection do
      get "list_notifications"
      get "notified"
    end
  end

  resources :schedules
  resources :practice_tables 
  resources :doc_abbreviations
  resources :file_namings
  resources :case_entry_billings
  
  root :to => 'case_entries#new'
  
  # ajax
  get 'pages/update_songs', :as => 'update_songs'
  get 'pages/update_songs2', :as => 'update_songs2'
  get 'pages/parse_client', :as => 'parse_client'
  get 'pages/update_case_entry', :as => 'update_case_entry'
  get 'pages/printouts_entry', :as => 'printouts_entry'
  get 'pages/update_cases', :as => 'update_cases'
  get 'pages/update_search_form', :as => 'update_search_form'
  get 'pages/schedule_entry', :as => 'schedule_entry'
  get 'pages/add_client_code', :as => 'add_client_code'
  get 'pages/pick_filematter', :as => 'pick_filematter'
  get 'pages/add_practice_code', :as => 'add_practice_code'
  get 'pages/select_file_matters', :as => 'select_file_matters'

  # search
  # match '/all_employees_list', :to => 'labor_hours#all_employees_list'
  match 'search_entry', :to  => 'case_entries#search_entry'
  match 'search_entry_multi', :to  => 'case_entries#search_entry_multi'
  match 'search_entry_graph', :to  => 'graphs#search_entry_graph'
  match 'search_entry_other_graph', :to  => 'graphs#search_entry_other_graph'
  match 'search_entry_other_graph2', :to  => 'graphs#search_entry_other_graph2'
  match 'exclude_billing', :to =>  'case_entries#exclude_billing'
  match 'modify_case_entry', :to =>  'case_entries#modify_case_entry'
  match 'case_entries/search' => 'case_entries#search_entry'
  match 'file_matters/search' => 'file_matters#search_entry'
  match '/admin_side/search' => 'admin_side#index'
  match 'activate_account', :to =>  'account/users#activate_account'
  match 'deactivate_account', :to =>  'account/users#deactivate_account'
  match 'activate_lawyer', :to =>  'lawyers#activate_account'
  match 'deactivate_lawyer', :to =>  'lawyers#deactivate_account'
  match 'exclude_printout', :to =>  'printouts#exclude_printout'
  match 'include_printout', :to =>  'printouts#include_printout'
  match 'search_by_client', :to => 'printouts#search_by_client'
  match 'weekly_view', :to => 'schedules#weekly_view'
  match 'daily_view', :to => 'schedules#daily_view'
  

  # recent modification for filtering data in case entries
  match 'filter_by_workload', :to => 'case_entries#filter_by_workload'
  match 'filter_by_client_code', :to => 'case_entries#filter_by_client_code'
  match 'filter_by_practice_code', :to => 'case_entries#filter_by_practice_code'
  match 'filter_by_period', :to => 'case_entries#filter_by_period'
  match 'filter_by_compared_workload', :to => 'case_entries#filter_by_compared_workload'

  # for timesheet additional tab and function
  match 'search_billed_entry', :to  => 'case_entries#search_billed_entry'
  match 'mark_as_billed', :to  => 'case_entries#mark_as_billed'
end
