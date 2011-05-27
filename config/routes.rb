Contest31::Application.routes.draw do
  root :to => 'rest#home'
  
  match '/rest/projects/show/:id(.:format)' => 'rest#show_id'
  match '/rest/projects/updated-list(.:format)' => 'rest#show_count'

  # match ':controller(/:action(/:id(.:format)))'
end
