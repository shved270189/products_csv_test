class ApplicationController < ActionController::Base
  DEFAULT_PER_PAGE = 10

  protect_from_forgery with: :exception
end
