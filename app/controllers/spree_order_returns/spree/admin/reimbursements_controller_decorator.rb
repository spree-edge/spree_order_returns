module SpreeOrderReturns
  module Spree
    module Admin
      module ReimbursementsControllerDecorator
        def self.prepended(base)
          base.before_action :load_refunds, only: %i(update)
        end

        def load_refunds
          @reimbursement_objects = @reimbursement.refunds
        end
      end
    end
  end
end

::Spree::Admin::ReimbursementsController.prepend ::SpreeOrderReturns::Spree::Admin::ReimbursementsControllerDecorator
