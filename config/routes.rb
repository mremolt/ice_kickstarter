IceKickstarter::Engine.routes.draw do
  resource :dashboard, only: [:show] do
    collection do
      get 'help'
      get 'people'
      get 'content'
    end
  end
end

Rails.application.routes.draw do
  mount IceKickstarter::Engine => '/cms'
end