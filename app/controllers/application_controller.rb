# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionsHelper

  private

  def require_login
    return if logged_in?

    flash[:notice] = 'ログインしてください'
    redirect_to welcome_path
  end
end
