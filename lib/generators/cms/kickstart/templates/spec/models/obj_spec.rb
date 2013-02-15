require 'spec_helper'

describe Obj do
  it 'caches its homepage' do
    parent = mock(Obj, homepage: mock(Obj))
    subject.should_receive(:parent).once.and_return(parent)

    subject.homepage
    subject.homepage
  end

  it 'caches its website' do
    homepage = mock(Obj, website: mock(Obj))
    subject.should_receive(:homepage).once.and_return(homepage)

    subject.website
    subject.website
  end
end