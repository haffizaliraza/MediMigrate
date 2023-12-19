class CoursesController < BaseController
  before_action :authorize_request
  before_action :set_course, only: %i[show edit destroy update toggle_cart]
  before_action :set_customer, :fetch_carts, only: %i[checkout]
  before_action :fetch_course, :set_chapter, :mark_chapter, only: %i[show]

  def index
    @courses = Course.ordered.page(params[:page])
  end

  def new
    @course = Course.new
    @course.chapters.build
    @course.lessons.build
  end

  def show
    if @purchased_course.chapters.length > 0
      if @purchased_course.course.chapters.length == @purchased_course.chapters.length
        @purchased_course.update(completed_status: 100)
      else
        score = ( 100 / @purchased_course.course.chapters.length) * @purchased_course.chapters.length
        @purchased_course.update(completed_status: score)
      end
    end

    redirect_to course_path(@purchased_course.course) if params[:chapter_id].blank? && params[:mark_chapter_id].present?
  end

  def edit; end

  def update
    if @course.update(course_params)
      redirect_to courses_path, notice: "Course updated successfully"
    else
      render :edit
    end
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to courses_path, notice: "Course created successfully"
    else
      render :new
    end
  end

  def destroy
    @result = @course.destroy
    if @result
      redirect_to courses_path, notice: "Course deleted successfully"
    else
      flash.now[:alert] = @course.errors.full_messages.to_sentence
    end
  end

  def for_student
    @courses = Course.where(status: 'publish').ordered
    @student_purchased = current_user.courses
    @not_purchased = @courses - @student_purchased
  end

  def toggle_cart
    cart_item = current_user.cart_items.find_by(course_id: @course.id)
    if cart_item.present?
      cart_item.destroy
    else
      current_user.cart_items.create(quantity: 1, course_id: @course.id)
    end
    respond_to do |format|
      format.json { render json: { cart_item: !cart_item.present?, cart_length: current_user.cart_items.length } }
    end
  end

  def checkout
    return redirect_to for_student_courses_path, alert: 'No item in cart found!' unless @stripe_items.present?

    session = Stripe::Checkout::Session.create({
      mode: 'payment',
      payment_method_types: %w[card],
      line_items: @stripe_items,
      customer: current_user.stripe_id,
      success_url: "#{request.protocol}#{request.host_with_port}/checkout_success?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: root_url,
    })

    redirect_to session.url, allow_other_host: true
  end

  private

  def mark_chapter
    if params[:mark_chapter_id].present?
      @purchased_course.update(current_chapter: (params[:chapter_id] || @purchased_course.course.chapters.first.id))

      ViewChapter.create(chapter_id: params[:mark_chapter_id], purchased_course_id: @purchased_course.id)
    end
  end

  def fetch_carts
    carts = CartItem.where(student_id: current_user.id)
    @stripe_items = []
    carts.each do |cart|
      @stripe_items << {
        price_data: {
          currency: 'usd',
          product_data: { name: cart.course.name}, unit_amount: cart.course.price * 100 },
          quantity: 1
        }
    end
  end

  def fetch_course
    @purchased_course = current_user.purchased_courses.find_by(course_id: params[:id])
    raise ActiveRecord::RecordNotFound unless @purchased_course
    @purchased_course.update(new_chapter: false) if @purchased_course.new_chapter
  end

  def authorize_request
    authorize %i[course]
  end

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course)
      .permit(:name, :description, :status, :price,
        chapters_attributes: [:id, :title, :_destroy,
          lessons_attributes: [:id, :title, :type, :file, :content, :url, :_destroy]
        ]
      )
  end

  def set_chapter
    @chapter = Chapter.find_by(id: params[:chapter_id] || @purchased_course.current_chapter || @purchased_course.course.chapters.first)
  end
end
