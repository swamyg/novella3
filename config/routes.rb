Novella3::Application.routes.draw do
  #root Default route
  root :to => "genre#show", :all=>'true'
  ##singular resource with mapping
  resources :novels, :requirements => {:id => /[0-9]+/} do
    resources :chapters
    resources :permissions
  end
  match 'novels/:novel_id/chapters/:chapter_no' => "chapters#show", :requirements => {:novel_id => /[0-9]+/, :chapter_no => /[0-9]+/}, :as => :chapter_no
  match 'user/:login' => "profiles#show", :requirements => {:login => /[a-z]+/}, :as => :profile
  resources :user, :requirements => {:id => /[0-9]+/} do
    resource :profile
    resources :novels
    resources :chapters
  end
  match 'accounts/:action' , :controller => "accounts", :action => :action, :as => :accounts
  ##Named Routes
  ##novel_id 'novels/:id', :controller => 'novels', :action => 'show',
  match 'novels/:perma_link' => "novels#show", :as => :perma_link, :perma_link => :perma_link
  match 'all/:view' => "genre#show",:defaults=>{:view=>'popular', :all=>'true'}, :as =>:all
  match '/:genre/(:view)' => "genre#show", :defaults=>{:view=>'popular'}, :as => 'genre'
  #genre ':genre', :controller => 'genre', :action => 'show', :requirements => {:genre => /[a-z]+/},:default=>{:view=>'popular'}
  match '/:controller(/:action(/:id))'
end
