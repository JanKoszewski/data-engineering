DataEngineering::Application.routes.draw do
  resources :invoices

  root :to => "invoices#index"
end
