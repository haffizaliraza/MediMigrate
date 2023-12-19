# frozen_string_literal: true

# View helper methods for Nav Items
#
module NavItemsHelper

  def admin_nav_list
    [
      { title: 'Dashboard', path_name: '/', icon: 'fa-tachometer-alt', path: route.root_path },
      { title: 'Users', path_name: 'users', icon: 'fa-users', path: route.users_path },
      { title: 'Courses', path_name: 'courses', icon: 'fa-graduation-cap', path: route.courses_path },
      { title: 'Jobs', path_name: 'jobs', icon: 'fa-file-invoice', path: route.jobs_path },
      { title: 'Job Applications', path_name: 'job_applications', icon: 'fa-file-pen', path: route.job_applications_path }
    ]
  end

  def employer_nav_list
    [
      { title: 'Dashboard', path_name: '/', icon: 'fa-tachometer-alt', path: route.root_path },
      { title: 'Courses', path_name: 'courses', icon: 'fa-graduation-cap', path: route.courses_path },
      { title: 'Jobs', path_name: 'jobs', icon: 'fa-file-invoice', path: route.jobs_path },
      { title: 'Job Applications', path_name: 'job_applications', icon: 'fa-file-pen', path: route.job_applications_path }
    ]
  end

  def student_nav_list
    [
      { title: 'Dashboard', path_name: '/', icon: 'fa-tachometer-alt', path: route.root_path },
      { title: 'Apply on Job', path_name: 'job', icon: 'fa-file-invoice', path: route.for_student_jobs_path },
      { title: 'Courses', path_name: 'courses', icon: 'fa-graduation-cap', path: route.for_student_courses_path }
    ]
  end

  def nav_items(user)
    user = user.class.name

    case user
    when 'AdminUser' then nav_items_list(admin_nav_list, true)
    when 'Employer' then nav_items_list(employer_nav_list, true)
    when 'Student' then nav_items_list(student_nav_list, true)
    else
      raise 'Invalid user for fetching nav list'
    end
  end

  def nav_items_list(list, _user_roles)
    nav_items = {}

    list.flat_map do |nav_item|
      nav_items.merge!(nav_item[:title].to_s => nav_item)
    end

    nav_items
  end

  def active_path?(path)
    path == '/' ? request.path.split('/')[1].blank? : request.path.include?(path)
  end

  private

  def route
    Rails.application.routes.url_helpers
  end
end
