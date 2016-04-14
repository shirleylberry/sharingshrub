# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string
#  admin                  :boolean          default("f")
#


require 'rails_helper'

describe User do
  
  describe 'a factory' do
    it 'makes a valid user' do
      user = build(:user)
      expect(user.save).to be(true)
    end
  end
  describe '#is_host' do 
    before do
      @user1 = build_stubbed(:user, name: "Host McGee")
      @user2 = build_stubbed(:user, name: "Bob Notahost")
      @host = build_stubbed(:host, user: @user1)
      @event = build_stubbed(:event, host: @host)
    end

    it 'returns true if the user is the host of the event' do
      expect(@user1.is_host(@event)).to be(true)
    end
    it 'returns false if the user is not the host of the event' do
      expect(@user2.is_host(@event)).to be(false)
    end
  end

  describe '#is_donor' do 
    before do
      @user1 = build(:user)
      @host = build(:host, user: @user1)
      @event = create(:event, host: @host)

      @user2 = build(:user)
      @donor = build(:donor, user: @user2)
      @pledge = create(:pledge, event: @event, donor: @donor)
    end

    it 'returns true if the user is a donor to the event' do
      binding.pry
      expect(@user2.is_donor(@event)).to be(true)
    end
    it 'returns false if the user is not a donor to the event' do
      expect(@user1.is_donor(@event)).to be(false)
    end
  end
end






