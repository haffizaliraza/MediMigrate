# frozen_string_literal: true

# Student model
#
class Student < User

  has_many :job_applications, foreign_key: "student_id", dependent: :restrict_with_error
  has_many :cart_items, foreign_key: "student_id", dependent: :destroy
  has_many :purchased_courses, foreign_key: "student_id", dependent: :destroy
  has_many :courses, through: :purchased_courses

  after_create :create_customer

  def student?
    true
  end

  def create_customer
    stripe_customer = Stripe::Customer.create(email: email, address: { country: 'AU' })
    self.stripe_id = stripe_customer.id
    self.save!
  end
end
