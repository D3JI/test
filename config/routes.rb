ActionController::Routing::Routes.draw do |map|
  map.resources :messages, :collection => { :message_to => :get, :trashbox => :put },
    :member => { :renew => :put, :reply => :get, :message_delete => :delete }

  map.resources :users do |user|
    user.resources :friends
    user.resources :comments, :member => {:delete_board => :delete }
    user.resources :entries do |entry|
      entry.resources :comments
    end
    user.resources :messages
    user.resources :albums do |album|
      album.resources :photos, :member => {:set_primary => :put, :set_avatar => :put } do |photo|
        photo.resources :comments
      end
    end
  end

  map.home '', :controller => 'home'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.login '/login', :controller => 'account', :action => 'login'
  map.logout '/logout', :controller => 'account', :action => 'logout'
  map.search '/search', :controller => 'search', :action => 'new'
  map.resources :forums
  map.resources :ads
  map.resources :votes
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
