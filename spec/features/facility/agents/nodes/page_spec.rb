require 'spec_helper'

describe "facility_agents_nodes_page", type: :feature, dbscope: :example do
  let(:site) {create :cms_site}
  let(:node) { create :facility_node_page }

  context "public" do

    before do
      Capybara.app_host = "http://#{site.domain}"
    end

    it "#index" do
      visit node.url
      expect(status_code).to eq 200
      expect(page).to have_css(".facility_page")

    end

    it "#index with kana" do
      visit node.url.sub('/', SS.config.kana.location + '/')
      expect(status_code).to eq 200
      expect(page).to have_css(".facility_page")
    end

    it "#index with mobile" do
      visit node.url.sub('/', site.mobile_location + '/')
      expect(status_code).to eq 200
      expect(page).to have_css(".facility_page")
    end

  end
end
