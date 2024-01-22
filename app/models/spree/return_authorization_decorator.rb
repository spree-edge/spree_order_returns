module Spree
  module ReturnAuthorizationDecorator
    def self.prepended(base)
      stock_location_validations = base._validators[:stock_location]
      if stock_location_validations.present?
        stock_location_validations.reject! { |validation| validation.is_a? ActiveRecord::Validations::PresenceValidator }
      end

      base._validate_callbacks.each do |callback|
        callback.raw_filter.attributes.delete :stock_location if callback.raw_filter.is_a?(ActiveModel::Validations::PresenceValidator)
      end

      base.validates :stock_location, presence: true, unless: :user_initiated?
      base.validates :return_items, presence: true, if: :user_initiated?

      base.state_machine initial: :unauthorized do
        before_transition to: :canceled, do: :cancel_return_items

        event :cancel do
          transition to: :canceled, from: :authorized, if: ->(return_authorization) { return_authorization.can_cancel_return_items? }
        end

        event :mark_authorized do
          transition to: :authorized, from: :unauthorized
        end
      end
    end

    def allow_return_item_changes?
      !customer_returned_items?
    end
  end
end

::Spree::ReturnAuthorization.prepend ::Spree::ReturnAuthorizationDecorator
