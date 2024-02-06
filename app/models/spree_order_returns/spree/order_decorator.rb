module SpreeOrderReturns
  module Spree
    module OrderDecorator
      SHIPPED_STATES = ['shipped', 'partial']

      def self.prepended(base)
        base.scope :returned, -> { where(shipment_state: SHIPPED_STATES) }
      end

      def has_returnable_products?
        products.returnable.exists?
      end

      def has_returnable_line_items?
        line_items.any?(&:is_returnable?)
      end

      def has_returnable_days?
        return false unless shipped?

        result = false
        products.each do |product|
          shipments.each do |shipment|
            next if shipment.state != 'shipped'
            result = shipment.shipped_at + product.product_return_data.dig('returnable_days').to_i.days >= Date.today
            return true if result
          end
        end
        result
      end
    end
  end
end

::Spree::Order.prepend ::SpreeOrderReturns::Spree::OrderDecorator
