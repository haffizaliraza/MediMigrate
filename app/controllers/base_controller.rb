class BaseController < ApplicationController
  layout 'dashboard'
  include Authorization
  include StripeConcern
  include ExceptionHandler

  before_action :authenticate_user!
end
