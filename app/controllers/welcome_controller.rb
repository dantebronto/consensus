class WelcomeController < ApplicationController
  skip_before_filter :login_required
end