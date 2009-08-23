ActionController::Routing::Routes.draw do |map|
  map.resources :users, :except => [:show]
  map.resources :sessions, :only => [:new, :create, :destroy]
  map.resources :votes, :except => [:edit], :member => { :prioritize => :get, :allocate => :get, :cast => :get }
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.about '/about', :controller => 'welcome', :action => 'about' 
  map.remuneration_schedule '/remuneration_schedule', :controller => 'remunerations', :action => 'edit'
  map.remuneration_schedule '/remuneration_schedule', :controller => 'remunerations', :action => 'update', :method => :put
  map.root :controller => 'welcome'
end