class ContactPageController < CmsController
  def index
    attributes = params[:contact_page_presenter] || {}
    @contact_page_presenter = ContactPagePresenter.new(current_user, attributes)

    if request.post? && @contact_page_presenter.valid?
      flash[:notice] = 'Contact form sent successfully.'

      ContactActivityService.new(
        @contact_page_presenter.attributes,
        @obj.activity_type,
        current_user
      ).submit

      redirect_to(cms_path(@obj.homepage))
    end
  end
end