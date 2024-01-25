module Spree
  module Admin
    module ReimbursementsControllerDecorator
      def self.prepended(base)
        base.before_action :load_refunds, only: %i(update)
        base.before_action :include_ensure_order_return_concern, only: :update
      end

      def load_refunds
        @reimbursement_objects = @reimbursement.refunds
      end

      private

      def include_ensure_order_return_concern
        self.class.send(:include, EnsureOrderReturn)
      end
    end
  end
end

::Spree::Admin::ReimbursementsController.prepend ::Spree::Admin::ReimbursementsControllerDecorator
