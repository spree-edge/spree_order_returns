module SpreeOrderReturns
  module Spree
    module Admin
      module ReturnAuthorizationsControllerDecorator
        def authorize
          @return_authorization = ::Spree::ReturnAuthorization.find_by(id: params['id'])
          if @return_authorization.stock_location.present?
            if @return_authorization.update(state: 'authorized')
              flash[:success] = 'Return Authorization is authorized!'
              redirect_to admin_order_return_authorizations_path(@order)
            else
              load_form_data
              render :edit, status: :unprocessable_entity
            end
          else
            load_form_data
            flash[:error] = 'Stock Location must be present'
            redirect_to edit_admin_order_return_authorization_path(@order, @return_authorization)
          end
        end
      end
    end
  end
end

::Spree::Admin::ReturnAuthorizationsController.prepend ::SpreeOrderReturns::Spree::Admin::ReturnAuthorizationsControllerDecorator
