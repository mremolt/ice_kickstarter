class ContactPageController < CmsController
  def index
    @contact_page_presenter = ContactPagePresenter.new(current_user, params[:contact_page_presenter])

    if request.post? && @contact_page_presenter.valid?
      flash[:notice] = I18n.t('flash.contact_page.success')

      ContactActivityService.new(
        @contact_page_presenter.attributes,
        @obj.activity_type,
        current_user
      ).submit

      redirect_to(cms_path(@obj.redirect_after_submit))
    end
  end
end