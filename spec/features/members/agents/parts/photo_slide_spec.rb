require 'spec_helper'

describe "member_agents_parts_photo_slide", type: :feature, dbscope: :example do
  let(:site)   { cms_site }
  let(:layout) { create_cms_layout [part] }
  let(:node)   { create :member_node, layout_id: layout.id }
  let(:part)   { create :member_part_photo_slide}

  context "public" do
    before do
      Capybara.app_host = "http://#{site.domain}"
    end

    it "#index" do

      @cur_part

      binding.pry

      visit node.url

      expect(status_code).to eq 200

      #expect(page).to have_css(".member-photo-slide")
      #expect(page).to have_css(".bx-thumbs")
      #expect(page).to have_css(".images")

    end

  end
end
