FactoryGirl.define do
  trait :member_part do
    cur_site { cms_site }
    cur_user { cms_user }
    name { unique_id.to_s }
    filename { "#{unique_id}.part.html" }
    route "member/free"
  end

  factory :member_part_photo_slide, class: Cms::Part::Crumb, traits: [:member_part] do
    route "member/photo_slide"
  end
end
