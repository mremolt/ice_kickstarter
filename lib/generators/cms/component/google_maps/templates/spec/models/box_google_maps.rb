require 'spec_helper'

describe BoxGoogleMaps do
  it 'inherits from Obj' do
    subject.should be_a(Obj)
  end

  describe 'pins' do
    it 'returns an array on [GoogleMapsPin.new]' do
      subject.stub(:pins).and_return([GoogleMapsPin.new])
      subject.pins.should be_an_instance_of(Array)
      subject.pins.count.should eq(1)
    end
  end

  describe 'zoom_level' do
    it 'returns 1 on 1' do
      subject.stub(:box_google_maps_center_zoom_level).and_return('1')
      subject.zoom_level.should eq('1')
    end
  end

  describe 'center_latitude' do
    it 'returns 1 on 1' do
      subject.stub(:box_google_maps_center_latitude).and_return('1')
      subject.center_latitude.should eq('1')
    end
  end

  describe 'center_longitude' do
    it 'returns 1 on 1' do
      subject.stub(:box_google_maps_center_longitude).and_return('1')
      subject.center_longitude.should eq('1')
    end
  end

  describe 'map_type' do
    it 'returns ROADMAP on ROADMAP' do
      subject.stub(:box_google_maps_map_type).and_return('ROADMAP')
      subject.map_type.should eq('ROADMAP')
    end
  end
end