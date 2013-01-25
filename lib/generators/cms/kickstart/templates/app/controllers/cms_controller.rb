class CmsController < RailsConnector::DefaultCmsController
  before_filter :check_domain

  # Delay the set_language filter after RC's load_obj
  skip_before_filter :set_language
  before_filter :set_language

  private

  def check_domain
    if check_domain?
      request_based_homepage = Homepage.homepage_for_hostname(request.host)

      if request_based_homepage != @obj.homepage
        Rails.logger.info "obj homepage #{@obj.homepage.path} != request homepage #{request_based_homepage.path}"
        Rails.logger.info "desired_hostname: #{@obj.homepage.desired_hostname}"

        redirect_to(cms_url(@obj, :host => @obj.homepage.desired_hostname))
      end
    end
  end

  def check_domain?
    (Rails.env.production? || Rails.env.staging?) &&
    request.host !~ /elb\.amazonaws\.com/ &&
    request.get?
  end

  # Overrides ApplicationController#determine_language
  def determine_language
    Rails.logger.debug("determine_language: @obj LANG: #{@obj.language}")

    @obj.language
  end
end