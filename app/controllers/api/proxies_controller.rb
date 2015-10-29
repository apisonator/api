class API::ProxiesController < API::BaseController

  def index
    respond_with current_user.proxies.order('id desc').page(params[:page])
  end

  def create
    respond_with current_user.proxies.create(proxy_params)
  end

  private

  def proxy_url(id)
    api_proxy_url(id)
  end

  def proxy_params
    params.permit(:endpoint, :subdomain)
  end

end
