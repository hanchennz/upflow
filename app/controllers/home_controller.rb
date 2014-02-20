class HomeController < ApplicationController
  # Formats
  respond_to :html

  def index
    render nothing: true, layout: true
  end
end
