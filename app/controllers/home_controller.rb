class HomeController < BaseController

  def index; end

  def checkout_success
    purchased_params = []
    current_user.cart_items.each do |cart|
      purchased_params << {
        course_id: cart.course_id,
        student_id: cart.student_id,
        stripe_session_id: params[:session_id],
        current_chapter: Chapter.find_by(course_id: cart.course_id)&.id
      }
    end
    PurchasedCourse.create(purchased_params)
    current_user.cart_items.destroy_all
    redirect_to for_student_courses_path, notice: 'Payemnt Successfully created!'
  end
end
