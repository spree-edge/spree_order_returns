Deface::Override.new(
  virtual_path: 'spree/users/show',
  name: 'account_returns_history',
  insert_before: 'table',
  partial: 'spree/users/returns_history'
)
