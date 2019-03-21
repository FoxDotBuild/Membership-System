Rails.application.routes.draw do
  resources :guest_book_entries, only: [ :create, :new ]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post "/kisi" => "web_hooks#kisi"
  get "/guest" => "guest_book_entries#new"
  root "home#root"
end
