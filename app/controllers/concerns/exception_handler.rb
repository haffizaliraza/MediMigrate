# frozen_string_literal: true

#
# Rescue Exception Handler included in the Application controller
#
module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |_exception|
      flash[:alert] = 'Record not found.'
      redirect_back(fallback_location: root_path)
    end
  end
end
