Contest31::Application.routes.draw do
  root :to => 'rest#api'
  
  match ':controller(/:action(/:id(.:format)))'
end
