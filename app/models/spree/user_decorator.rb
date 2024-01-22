module Spree::UserDecorator
  def self.prepended(base)
    base.has_many :return_authorizations, through: :orders
  end
end

Spree::User.prepend Spree::UserDecorator
