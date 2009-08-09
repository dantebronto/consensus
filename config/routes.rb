ActionController::Routing::Routes.draw do |map|
  map.resources :users
  map.resources :sessions, :only => [:new, :create, :destroy]
  map.root :controller => "users", :action => "index"
end
