module SpreeOrderReturns
  module Spree
    module UserDecorator
      def self.prepended(base)
        base.has_many :return_authorizations, through: :orders
      end
    end
  end
end

Spree::User.prepend ::SpreeOrderReturns::Spree::UserDecorator
