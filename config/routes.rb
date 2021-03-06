ActionController::Routing::Routes.draw do |map|
  map.resources :remunerations
  map.remuneration_category '/remunerations/:id/:category', :controller => 'remunerations', :action => 'categories'
  map.resources :users, :except => [:show]
  map.resources :sessions, :only => [:new, :create, :destroy]
  map.resources :votes, :except => [:edit], :member => { :prioritize => :get, :allocate => :get, :cast => :get }
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.about '/about', :controller => 'welcome', :action => 'about'
  map.usage '/usage', :controller => 'welcome', :action => 'usage'
  map.root :controller => 'welcome'
end