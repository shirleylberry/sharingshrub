
require 'rails_helper'

describe Donor do

  describe '#total_pledged' do
    let(:user) {User.create(name: "Bobbo", email: "bobbo@example.com", password: "8123jknasd")}
    let(:host_user) {User.create(name: "Yakko", email: "yakko@example.com", password: "8123jknasd")}
    let(:host) {Host.create(user:host_user)}
    let(:donor) {Donor.create(user: user)}

    let(:event) {Event.create(title: "UNICEF Benefit", host: host, event_start: Time.new(2016, 10, 10, 17, 40), event_end: Time.new(2016, 10, 11, 12, 40))}
    let!(:pledge) {Pledge.create(event: event, donor: donor, amount: 25)}
    let(:event2) {Event.create(title: "Drs w/o Borders Gala", host: host, event_start: Time.new(2016, 10, 10, 17, 40), event_end: Time.new(2016, 10, 11, 12, 40))}
    let!(:pledge2) {Pledge.create(event: event2, donor: donor, amount: 40)}
    it 'returns the amount the donor has pledged' do
      expect(donor.total_pledged).to eq(65)
    end
  end

  describe '#pledged_events' do
    let(:user) {User.create(name: "Bobbo", email: "bobbo@example.com", password: "8123jknasd")}
    let(:host_user) {User.create(name: "Yakko", email: "yakko@example.com", password: "8123jknasd")}
    let(:host) {Host.create(user:host_user)}
    let(:donor) {Donor.create(user: user)}

    let(:event) {Event.create(title: "UNICEF Benefit", host: host, event_start: Time.new(2016, 10, 10, 17, 40), event_end: Time.new(2016, 10, 11, 12, 40))}
    let!(:pledge) {Pledge.create(event: event, donor: donor, amount: 25)}
    let(:event2) {Event.create(title: "Drs w/o Borders Gala", host: host, event_start: Time.new(2016, 10, 10, 17, 40), event_end: Time.new(2016, 10, 11, 12, 40))}
    let!(:pledge2) {Pledge.create(event: event2, donor: donor, amount: 40)}
    it 'returns the events the donor has pledged to' do
      binding.pry
      expect(donor.pledged_events).to eq([event, event2])
    end
  end
end






