Spree::Core::Engine.add_routes do
  # Add your extension routes here
  resources :orders do
    resources :return_authorizations, only: [:new, :create, :show]
  end
  resources :return_authorizations, only: :index

  put 'admin/orders/:order_id/return_authorizations/:id/authorize', to: 'admin/return_authorizations#authorize', as: :authorize_return_authorization

end
