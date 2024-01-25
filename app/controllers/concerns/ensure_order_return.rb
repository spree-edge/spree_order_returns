module EnsureOrderReturn
  extend ActiveSupport::Concern

  # filter for checking if this feature is enabled or not before running any controller action
  included do
    before_action :ensure_order_returns_enabled
  end

  def ensure_order_returns_enabled
    raise CanCan::AccessDenied unless Flipper.enabled?(:order_returns, current_store.try(:id))
  end
end
