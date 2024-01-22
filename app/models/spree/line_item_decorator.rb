module Spree
  module LineItemDecorator
    def is_returnable?
      return product.returnable?
    end
  end
end

::Spree::LineItem.prepend ::Spree::LineItemDecorator
