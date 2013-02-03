require 'spec_helper'

describe ContactPage do
  it 'inherits from Obj' do
    subject.should be_a(Obj)
  end

  it 'responds to show_in_navigation' do
    subject.should respond_to(:show_in_navigation)
  end

  it 'responds to activity_type' do
    subject.should respond_to(:activity_type)
  end

  it 'should be a Page' do
    subject.should be_a(Page)
  end
end