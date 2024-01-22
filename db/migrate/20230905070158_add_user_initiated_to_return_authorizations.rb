class AddUserInitiatedToReturnAuthorizations < ActiveRecord::Migration[6.1]
  def change
     add_column :spree_return_authorizations, :user_initiated, :boolean, default: false
  end
end
