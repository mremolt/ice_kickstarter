require 'spec_helper'

describe ProfilePageController do
  let(:homepage) { mock_model(Homepage, :permalink => 'homepage') }
  let(:profile_page) { mock(ProfilePage, :locale => 'de') }

  before do
    request.for_cms_object(profile_page)

    controller.stub(:ensure_object_is_active).and_return(true)
    controller.stub(:ensure_object_is_permitted).and_return(true)
    controller.stub(:set_google_expire_header).and_return(true)
  end

  describe 'get index' do
    it 'renders index template' do
      get :index

      response.should render_template(:index)
    end

    it 'assigns @profile_page_presenter' do
      get :index

      assigns[:profile_page_presenter].should be_a(ProfilePagePresenter)
    end
  end

  describe 'post index' do
    it 'assigns @profile_page_presenter' do
      post :index

      assigns[:profile_page_presenter].should be_a(ProfilePagePresenter)
    end

    context 'invalid data' do
      it 'renders index template' do
        post :index

        response.should render_template(:index)
      end
    end

    context 'valid data' do
      let(:service) { mock_model('Service', :submit => true) }
      let(:attributes) { { 'email' => 'test@test.de', 'last_name' => 'test' } }

      before do
        ContactActivityService.should_receive(:new).with(attributes, profile_page.activity_type, anything).and_return(service)
      end

      it 'redirects to hompage' do
        post :index, { :profile_page_presenter => attributes }

        response.should redirect_to("http://test.host/#{homepage.permalink}")
      end

      it 'sets flash notice' do
        post :index, { :profile_page_presenter => attributes }

        flash[:notice].should be_present
      end
    end
  end
end