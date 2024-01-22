module Spree
  module ReturnItemDecorator
    def self.prepended(base)
      base.validate :ensure_exchange_variant
    end

    def returnable?
      inventory_unit.variant.product.returnable?  && (inventory_unit.shipment.shipped_at + inventory_unit.variant.product.product_return_data.dig('returnable_days').to_i.days >= Date.today)
    end

    def returned?
      inventory_unit.shipped? && return_authorization.allow_return_item_changes? && !reimbursement
    end

    def ensure_exchange_variant
      override_reimbursement_type = Spree::ReimbursementType.find_by(id: override_reimbursement_type_id || preferred_reimbursement_type_id)
      return unless override_reimbursement_type.present? && override_reimbursement_type.type == 'Spree::ReimbursementType::Exchange'

      errors.add(:exchange_variant, "must be present") unless exchange_variant_id.present?
    end
  end
end

Spree::ReturnItem.prepend Spree::ReturnItemDecorator
