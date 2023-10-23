class InfoController < ApplicationController
  def index
    render json: { app: 'go-rails-api', version: '0.0.1' }
  end
end
