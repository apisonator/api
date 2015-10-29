class API::ReleasesController < API::BaseController

  def index
    respond_with current_user.releases.order('id desc').page(params[:page])
  end

  def create
    respond_with current_user.releases.create
  end

  private

  def release_url(release)
    api_release_url(release)
  end
end
