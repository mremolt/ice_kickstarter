class RedirectController < CmsController
  def index
    if @obj.redirect_link?
      target = cms_path(@obj.redirect)

      redirect_to(target)
    else
      flash[:alert] = I18n.t('redirect.index.link_undefined')
    end
  end
end