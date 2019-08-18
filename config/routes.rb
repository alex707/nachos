Rails.application.routes.draw do
  post 'exports/download'
  get 'top_screen/search'
  post 'top_screen/search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
