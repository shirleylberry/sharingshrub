# == Schema Information
#
# Table name: donors
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# # == Schema Information
# #
# # Table name: donors
# #
# #  id         :integer          not null, primary key
# #  user_id    :integer
# #  created_at :datetime         not null
# #  updated_at :datetime         not null
# #

require 'rails_helper'

describe Donor do

  describe '#total_pledged' do
    before do
      @donor = build(:donor, :with_pledges)
    end

    it 'finds total pledged' do
      expect(@donor.total_pledged).to eq(105)
    end
  end

  describe '#pledged_events' do
    it 'gets the pledged events' do
      
    end
  end
end






