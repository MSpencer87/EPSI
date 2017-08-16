Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'

  get 'ipaddr', to: 'home#show'
  get 'pword', to: 'home#pass'
  post 'filename' , to: 'home#upload'
  get 'iface', to: 'home#sniff'

  resources :pages do
	collection do
		get :scan
	end
  end


end
