class AddProductReturnDataToSpreeProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :spree_products, :product_return_data, :jsonb, default: { "returnable": false, "returnable_days": 0 }
  end
end
