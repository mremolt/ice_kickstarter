require 'spec_helper'

describe GoogleMapsPin do
  it 'inherits from Obj' do
    subject.should be_a(Obj)
  end

  describe 'longitude' do
    it 'returns 1 on 1' do
      subject.stub(:google_maps_pin_longitude).and_return('1')
      subject.longitude.should eq('1')
    end
  end

  describe 'latitude' do
    it 'returns 1 on 1' do
      subject.stub(:google_maps_pin_latitude).and_return('1')
      subject.latitude.should eq('1')
    end
  end
end