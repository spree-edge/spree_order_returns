module SpreeOrderReturns
  module Spree
    module LineItemDecorator
      def is_returnable?
        return product.returnable?
      end
    end
  end
end

::Spree::LineItem.prepend ::SpreeOrderReturns::Spree::LineItemDecorator
