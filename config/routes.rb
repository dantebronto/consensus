ActionController::Routing::Routes.draw do |map|
  map.resources :users, :except => [:show]
  map.resources :sessions, :only => [:new, :create, :destroy]
  map.login "/login", :controller => "sessions", :action => "new"
  map.logout "/logout", :controller => "sessions", :action => "destroy"
  map.root :controller => "welcome"
end