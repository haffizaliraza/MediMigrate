# frozen_string_literal: true

class CartItem < ApplicationRecord

  belongs_to :course
  belongs_to :student, class_name: "User"
end
