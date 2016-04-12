
require 'rails_helper'

describe User do
  describe '#is_host' do 
    let(:user) {User.create(name: "Bobbo", email: "bobbo@example.com", password: "8123jknasd")}
    let(:host) {Host.create(user: user)}

    let(:event) {Event.create(title: "UNICEF Benefit", host: host, event_start: Time.new(2016, 10, 10, 17, 40), event_end: Time.new(2016, 10, 11, 12, 40))}
    
    let(:user2) {User.create(name: "Yakko", email: "yakko@example.com", password: "8123jknasd")}
    let(:host2) {Host.create(user: user2)}
    it 'returns true if the user is the host of the event' do
      expect(user.is_host(event)).to be(true)
    end
    it 'returns false if the user is not the host of the event' do
      expect(user2.is_host(event)).to be(false)
    end
  end

  describe '#is_donor' do
    let(:user) {User.create(name: "Bobbo", email: "bobbo@example.com", password: "8123jknasd")}
    let(:host_user) {User.create(name: "Yakko", email: "yakko@example.com", password: "8123jknasd")}
    let(:host) {Host.create(user:host_user)}
    let(:donor) {Donor.create(user: user)}

    let(:event) {Event.create(title: "UNICEF Benefit", host: host, event_start: Time.new(2016, 10, 10, 17, 40), event_end: Time.new(2016, 10, 11, 12, 40))}
    let!(:pledge) {Pledge.create(event: event, donor: donor)}

    let(:user2) {User.create(name: "Yakko", email: "yakko@example.com", password: "8123jknasd")}
    let(:donor2) {Donor.create(user: user2)}

    it 'returns true if the user has donated' do
      expect(user.is_donor(event)).to be(true)
    end
    it 'returns false if the user has not donated' do
      expect(user2.is_donor(event)).to be(false)
    end
  end
end






