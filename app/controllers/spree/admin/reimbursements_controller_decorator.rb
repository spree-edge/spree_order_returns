module Spree
  module Admin
    module ReimbursementsControllerDecorator
      def self.prepended(base)
        base.before_action :load_refunds, only: %i(update), if: -> {Flipper.enabled?(:order_return, current_store.try(:id)) }
      end

      def load_refunds
        @reimbursement_objects = @reimbursement.refunds
      end
    end
  end
end

::Spree::Admin::ReimbursementsController.prepend ::Spree::Admin::ReimbursementsControllerDecorator
