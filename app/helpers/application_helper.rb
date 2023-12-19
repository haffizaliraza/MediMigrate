module ApplicationHelper
  def current_user_sidebar(user)

    case user.class.name
    when 'AdminUser' then 'admin_sidebar'
    when 'Employer' then 'employer_sidebar'
    when 'Student' then 'student_sidebar'
    else
      raise 'Invalid user for sidebar'
    end
  end

  def job_location_options(location)
    cities = CS.get(:pk, :pb).map{ |value| "#{value}, #{CS.countries()[:PK]}" }
    cities.include?(location) ? cities : cities.push(location)
  end

  def application_status
    {
      pending_review: 'bg-secondary',
      accepted: 'bg-success',
      rejected: 'bg-danger'
    }
  end

  def next_chapter_id(purchased_course)
    remaining_ids = purchased_course.course&.chapters&.pluck(:id) - [params[:chapter_id]&.to_i]
    remaining_ids = remaining_ids - purchased_course.chapters&.pluck(:id)
    remaining_ids.first
  end

  def mark_chapter_id(purchased_course)
    return nil if params[:chapter_id].blank?

    params[:chapter_id].to_i unless purchased_course.chapters.pluck(:id).include?(params[:chapter_id].to_i)
  end

  def chapter_completed(purchased_course, chapter_id, index)
    purchased_course.chapters.pluck(:id).include?(chapter_id) && !active_chapter(chapter_id, index)
  end

  def course_status(course_id)
    purchased_course = current_user.purchased_courses.find_by(course_id: course_id)
    return 0 if purchased_course.blank?

    purchased_course.completed_status
  end

  def active_chapter(chapter_id, index)
    return index == 0 if params[:chapter_id].blank?

    params[:chapter_id].to_i.eql?(chapter_id)
  end

  def truncate_words(description)
    max_words = 20
    omission = '...'
    words = description.split(' ')
    truncated_description = words.take(max_words).join(' ')

    truncated_description += omission if words.length > max_words

    truncated_description
  end

  def current_chapter_path(course)
    purchased_courses = current_user.purchased_courses.find_by(course_id: course.id)

    course_path(course,  chapter_id: purchased_courses.current_chapter)
  end
end
