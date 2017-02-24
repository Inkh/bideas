Rails.application.routes.draw do
  get 'ideas/view'

  get '/view/:id' =>'users#view'

  get '/' => 'users#index'

  get 'show/:id' => 'users#show'

  get 'view/:id' => 'users#view'

  get 'idea/show/:id' => 'ideas#view'
  
  post 'register' => 'users#register'

  post 'log' => 'users#log'

  post 'out' => 'users#out'

  post 'create_idea' => 'users#idea'

  post 'destroy_idea/:id' => 'users#destroy_idea'

  post 'like_idea/:id' => 'users#like'

  post 'unlike_idea/:id' => 'users#unlike'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
