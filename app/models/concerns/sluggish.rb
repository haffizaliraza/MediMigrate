# frozen_string_literal: true
module Sluggish
  def self.included(object)
    object.extend(ClassMethods)
  end

  module ClassMethods
    def by_slug_or_id(slug_or_id)
      find_by(slug: slug_or_id.try(:downcase)) || find_by(id: slug_or_id)
    end

    def by_slug_or_id!(slug_or_id)
      find_by!(slug: slug_or_id.try(:downcase)) rescue find_by!(id: slug_or_id)
    end
  end

  def slug_url
    self.title.to_s.parameterize
  end

  def to_param
    self.slug
  end

  def set_slug
    return if slug.present?
    slug_name = title.parameterize
    slug_extension = nil
    while self.class.find_by(slug: [slug_name, slug_extension].compact.join('-'))
      slug_extension = slug_extension.to_i + 1
    end
    self.slug = [slug_name, slug_extension].compact.join('-')
  end
end
