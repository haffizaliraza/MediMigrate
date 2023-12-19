# frozen_string_literal: true

# Authorization helpers (Uses Pundit)
#
module StripeConcern
  extend ActiveSupport::Concern

  def set_customer
    return @customer = current_user if current_user.stripe_id.present?

    if current_user.student?
      stripe_customer = Stripe::Customer.create(email: current_user.email, address: { country: 'AU' })
      current_user.update(stripe_id: stripe_customer.id)
      @customer = current_user
    else
      flash[:alert] = 'Something went wrong!'
      redirect_back(fallback_location: root_path)
    end
  end
end
