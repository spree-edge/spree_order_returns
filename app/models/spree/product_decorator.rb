module Spree
  module ProductDecorator
    def self.prepended(base)
      base.validate :returnable_days_numericality
      base.scope :returnable, -> { where("product_return_data->>'returnable' = ?", '1') }
    end

    def returnable?
      return product_return_data.dig('returnable') == '1'
    end

    def returnable_days_numericality
      return unless product_return_data && returnable?
      returnable_days = product_return_data['returnable_days'].to_i
      unless returnable_days.is_a?(Numeric) && returnable_days > 0
        errors.add(:returnable_days, 'must be a numeric value and greater than 0')
      end
    end
  end
end

Spree::Product.prepend Spree::ProductDecorator
