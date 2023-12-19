# frozen_string_literal: true

# Employer model
#
class Employer < User

  has_many :job_applications, foreign_key: "employer_id", dependent: :restrict_with_error

  def employer?
    true
  end
end
