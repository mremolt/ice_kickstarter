class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :detect_preview_mode
  before_filter :detect_live_environment
  before_filter :select_workspace
  before_filter :set_language

  rescue_from RailsConnector::ResourceNotFound,
    ActiveResource::ResourceNotFound,
    :with => :not_found

  def preview_mode?
    session[:edit_marker]
  end

  private

  def detect_preview_mode
    session[:edit_marker] =
      request.host =~ /elb\.amazonaws\.com|\.dev|localhost$/ &&
      logged_in? &&
      current_user.role_names.include?('cmsadmin')

    Rails.logger.debug "detect_preview_mode: #{session[:edit_marker]}"
  end

  def detect_live_environment
    session[:live_environment] = %w(production staging).include?(Rails.env) && request.host !~ /elb\.amazonaws\.com$/

    Rails.logger.debug "detect_live_environment: #{session[:live_environment]}"
  end

  def select_workspace
    if params['ws'] && !session[:live_environment]
      workspaces = RailsConnector::CmsRestApi.get('workspaces')['results']
      workspace = workspaces.detect do |workspace|
        workspace['title'] == params['ws']
      end

      if workspace
        redirect_to(request.path + "?_rc-ws=#{workspace['id']}")
      end
    end
  end

  def set_language
    session[:language] = I18n.locale = determine_language

    Rails.logger.debug("set_language: using LANG=#{I18n.locale}")
  end

  def determine_language
    Rails.logger.debug("determine_language: session LANG=#{session[:language]}")

    session[:language].presence || I18n.default_locale
  end

  def current_user
    @current_user ||= session[:user] ? Infopark::Crm::Contact.new(session[:user]) : nil
  end

  def cache_current_user(user)
    session[:user] = {
      :id => user.id,
      :login => user.login,
      :role_names => user.role_names
    }
  end

  def discard_current_user
    session.delete(:user)
  end

  def logged_in?
    current_user
  end

  def not_found
    @obj = Homepage.homepage_for_hostname(request.host).error_404_page.destination_objects.first

    respond_to do |type|
      type.html { render :template => 'error_page/index', :status => 404 }
      type.all  { render :nothing => true, :status => 404 }
    end

    true
  end
end