class API::ReleasesController < API::BaseController

  def create
    respond_with current_user.releases.create
  end

  private

  def release_url(release)
    api_release_url(release)
  end
end
