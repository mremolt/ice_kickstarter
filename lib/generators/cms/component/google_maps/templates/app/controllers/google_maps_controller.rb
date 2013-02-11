class GoogleMapsController < CmsController
  def show
    @google_maps = BoxGoogleMaps.find(params[:id])

    respond_to do |format|
      format.json { render :json => {:map => @google_maps} }
    end
  end
end