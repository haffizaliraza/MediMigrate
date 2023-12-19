# frozen_string_literal: true

# Concern for filters
#
module FilterScopes
  extend ActiveSupport::Concern

  included do
    scope :ordered, ->(column: :created_at, sort: :asc) { order(column => sort) }
  end
end
