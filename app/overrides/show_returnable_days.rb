Deface::Override.new(
  virtual_path: 'spree/products/show',
  name: 'product_show_return_time',
  insert_bottom: "[data-hook=product_description]",
  partial: 'spree/products/returnable_days'
)
