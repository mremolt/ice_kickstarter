require 'spec_helper'

describe GoogleAnalytics do
  it 'inherits from RailsConnector::Obj' do
    subject.should be_a(RailsConnector::Obj)
  end

  describe 'anonymize_ip' do
    let(:subject) { GoogleAnalytics.new }

    it 'returns true on "Yes"' do
      subject.stub(:[]).with(:anonymize_ip).and_return('Yes')
      subject.anonymize_ip?.should be_true
    end

    it 'returns false on "NO"' do
      subject = GoogleAnalytics.new
      subject.stub(:[]).with(:anonymize_ip).and_return('No')
      subject.anonymize_ip?.should be_false
    end

    it 'returns false on nil' do
      subject = GoogleAnalytics.new
      subject.stub(:[]).with(:anonymize_ip).and_return(nil)
      subject.anonymize_ip?.should be_false
    end
  end

  describe 'tracking_id' do
    let(:subject) { GoogleAnalytics.new }

    it 'returns 123 on 123' do
      obj = GoogleAnalytics.new
      obj.stub(:[]).with(:tracking_id).and_return('123')
      obj.tracking_id.should eq('123')
    end

    it 'returns empty string on nil' do
      obj = GoogleAnalytics.new
      obj.stub(:[]).with(:tracking_id).and_return(nil)
      obj.tracking_id.should eq('')
    end
  end
end