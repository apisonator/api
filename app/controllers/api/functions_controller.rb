class API::FunctionsController < API::BaseController

  def index
    get_release
    respond_with @release.functions.order('id desc').page(params[:page])
  end

  def create
    get_release
    respond_with @release.functions.create(function_params)
  end

  private

  def get_release
    @release = current_user.releases.find(params[:release_id])
  end

  def function_url(id)
    api_function_url(id)
  end

  def function_params
    params.permit(:name, :content)
  end

end
