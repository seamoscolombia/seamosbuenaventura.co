Rails.application.routes.draw do
  root 'intro#inicio'

  resources :photos, only: :create

  resources :usuarios , except: [:new, :show] do
    get 'already_voted', on: :member
    get 'validate', on: :member
    patch 'update_valid_usuario', on: :member
  end

  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/sessions', to: 'sessions#destroy', as: 'session'
  post '/sessions', to: 'sessions#create', format: 'json'
  get '/auth/sessions', to: 'sessions#error'

  patch 'debate/:id', to: 'debates#publish', as: :publish_debate
  patch 'poll/:id', to: 'polls#toggle_status', as: :toggle_poll_status

  resources :polls do
    get 'last', on: :collection
    get 'voted', on: :collection
    resources :debates, on: :collection
    get '/debates/:id/change_debate_state', to: 'debates#change_debate_state', as: :change_debate_state
  end
  resources :tipo_de_documentos, only: :index
  resources :votes, only: :create
  resources :debate_votes, only: :create
  get '/tags', to: 'tags#index'
  resources :admin, only: [:create, :new]
  scope '/admin' do
    # get '/', to: 'sessions#new'
    post '/tags', to: 'tags#create', as: :admin_tags
    get '/tags/new', to: 'tags#new', as: :new_tags
    delete '/tags/:id', to: 'tags#delete', as: :delete_tag
    get 'polls', to:  'polls#index_admin', as: :admin_polls
    get '/', to: 'sessions#new', as: :admin_login
    post '/sessions', to: 'sessions#admin_create', as: :admin_session
    get 'validate-users', to: 'usuarios#index'
    resources 'dashboard', only: :index
  end

  mount ActionCable.server => '/cable'
end
