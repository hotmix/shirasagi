require 'spec_helper'

describe Member::BlogPageHelper, type: :helper do
  let(:site) { create :cms_site }
  let(:node) { create :cms_node }

  context '#render_blog_list' do

    before do
      Capybara.app_host = "http://#{site.domain}"
    end

    it "#index" do
      render :template => "member/apis/agents/nodes/blog/index.html.erb"

      expect(rendered).to match /member-blogs/

    end
  end
end
