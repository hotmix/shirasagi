require 'spec_helper'

describe Member::BlogPageHelper, type: :helper do
  let(:site)   { cms_site }
  let(:layout) { create_cms_layout [part] }
  let(:node)   { create :cms_node, layout_id: layout.id }
  let(:part)   { create :cms_part_page }

  context '#render_blog_list' do

    before do
      Capybara.app_host = "http://#{site.domain}"
    end

    it "#index" do
      assign(:cur_part, node)
      assign(:cur_date, Date.today)

      render :template => "member/agents/nodes/blog/index.html.erb"
      expect(rendered).to match /member-blogs/

    end
  end
end
