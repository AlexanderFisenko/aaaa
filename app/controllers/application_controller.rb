class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def markdown(text)
    Redcarpet.new(text).to_html.html_safe
  end
end
