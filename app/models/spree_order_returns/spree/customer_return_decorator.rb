module SpreeOrderReturns
  module Spree
    module CustomerReturnDecorator
      def self.prepended(base)
        base.validate :authorised_return_authorization
      end

      def authorised_return_authorization
        return unless order.present?
        errors.add(:base, 'Return Authorization is unauthorised') if order.return_authorizations.pluck(:state).include?('unauthorized')
      end

    end
  end
end

::Spree::CustomerReturn.prepend ::SpreeOrderReturns::Spree::CustomerReturnDecorator
