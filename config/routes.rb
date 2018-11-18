Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post "/kisi" => "web_hooks#kisi"
  root "home#root"
end
