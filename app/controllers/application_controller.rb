class ApplicationController < ActionController::Base
  include JSON_LD_Helper
  include QueryHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout 'application'

  def index
  end
end
