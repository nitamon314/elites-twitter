class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_search

  
  before_action :authenticate_user!
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def set_search
  @search = Tweet.ransack(params[:q]) 
  @search_tweets = @search.result.page(params[:page])
  end
  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :image, :profile])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :image, :profile])
  end
end
