class HealthController < ApplicationController
  def show
    render json: { message: I18n.t('messages.ok') }
  end
end
