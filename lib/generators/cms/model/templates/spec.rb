require 'spec_helper'

describe <%= class_name %> do
  it 'inherits from RailsConnector::Obj' do
    subject.should be_a(RailsConnector::Obj)
  end
end