require 'spec_helper'

describe ContactPagePresenter do

  context 'no attributes but user with email given' do
    let(:subject) { ContactPagePresenter.new(user, {}) }

    context 'user with valid email' do
      let(:user) { mock(User, email: 'test@test.de') }

      it 'prefills email from user' do
        subject.email.should eq('test@test.de')
      end

      it 'validates subject for presence' do
        subject.valid?

        subject.errors.should include(:subject)
      end
    end

    context 'user without email' do
      let(:user) { mock(User, email: nil) }

      it 'validates email presence' do
        subject.valid?

        subject.errors.should include(:email)
      end
    end

    context 'user with invalid email' do
      let(:user) { mock(User, email: 'test') }

      it 'validates email presence' do
        subject.valid?

        subject.errors.should include(:email)
      end
    end
  end
end