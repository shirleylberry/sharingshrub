require 'rails_helper'

describe Adapters::CharityClient do
  describe 'create_charities' do
    let(:charity_hash) {
      charities = [
      {:name=>"National Urban League (National Office)",
      :rating=>"A",
      :url_path=>"/ratings-and-metrics/national-urban-league-national-office/19",
      :cause=>"African American",
      :website=>"http://www.nul.org",
      :address=>"120 Wall St Fl 7 8th Floor New York, NY 10005-3900",
      :mission=>"To enable African-American and other urban communities to secure economic self-reliance, parity, power, and civil rights."},
     {:name=>"American Foundation for Children with AIDS",
      :rating=>"B+",
      :url_path=>"/ratings-and-metrics/american-foundation-for-children-with-aids/590",
      :cause=>"Aids",
      :website=>nil,
      :address=>"6221 Blue Grass Avenue Harrisburg, PA 17112 www.afcaids.org",
      :mission=>"To help HIV+/AIDS children and their guardians in Sub-Saharan Africa who have no other access to aid.  "},
     {:name=>"American Sexual Health Association ",
      :rating=>"A",
      :url_path=>"/ratings-and-metrics/american-sexual-health-association/22",
      :cause=>"Aids",
      :website=>nil,
      :address=>"P.O. Box 13827 Research Triangle Park, NC 27709 www.ashasexualhealth.org",
      :mission=>
       "Promote the sexual health of individuals, families & communities by advocating sound policies & practices and educating the public, professionals & policy makers, in order to foster healthy sexual behaviors & relationships and prevent adverse health outcomes."}
      ]
    }

    let(:client) {Adapters::CharityClient.new}

    it 'creates valid charities' do
      client.create_charities(charity_hash)
      expect(Charity.all).to include(Charity.find_by(name: "National Urban League (National Office)"))
    end

    it 'adds the cause to the charity causes' do
      client.create_charities(charity_hash)
      causes = Charity.find_by(name: "National Urban League (National Office)").causes
      cause = Cause.find_by(name: "African American")
      expect(causes).to include(cause)
    end
  end
end




