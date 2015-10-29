class WelcomeController < ApplicationController

  before_action :authenticate_user!

  def index
    render text: current_user.api_key
  end
end
