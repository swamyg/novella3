Novella3::Application.routes.draw do
  #root Default route
  root :to => "genre#show", :all=>'true'
  ##singular resource with mapping
  match 'novels/:novel_id/chapters/:chapter_no' => "chapters#show", :requirements => {:novel_id => /[0-9]+/, :chapter_no => /[0-9]+/}, :as => :chapter_no
  resources :novels, :requirements => {:id => /[0-9]+/} do
    resources :chapters
  end
  resources :users, :requirements => {:id => /[0-9]+/} do
    resource :profile
    resources :novels
    resources :chapters
  end
  match 'accounts/:action' => "accounts", :as => :accounts
  ##Named Routes
  ##novel_id 'novels/:id', :controller => 'novels', :action => 'show',
  match 'novels/:perma_link' => "novels#show", :as => :perma_link, :perma_link => :perma_link
  match 'users/:login' => "profiles#show", :requirements => {:login => /[a-z]+/}, :as => :profile
  match 'all/:view' => "genre#show",:defaults=>{:view=>'popular', :all=>'true'}, :as =>:all
  match '/:genre/(:view)' => "genre#show", :defaults=>{:view=>'popular'}, :as => 'genre'
  #genre ':genre', :controller => 'genre', :action => 'show', :requirements => {:genre => /[a-z]+/},:default=>{:view=>'popular'}
  match '/:controller(/:action(/:id))'
end
