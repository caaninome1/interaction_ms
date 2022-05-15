Rails.application.routes.draw do
  resources :users_matches
  resources :likes
  get 'likes/user/:user_id' => 'likes#user_likes'
  get 'likes/user_liked/:user_id' => 'likes#user_liked_likes'
  get 'users_matches/user/:user_id' => 'users_matches#user_likes'
end
