module ApplicationHelper
  def body_attributes
    {
      class: [
        params[:controller],
      ],
    }
  end
end