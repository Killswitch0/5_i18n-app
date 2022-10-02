class WelcomeController < ApplicationController
  def index
    @xss = "<script>alert('hi')</script>"
  end
end
