class PagesController < ApplicationController

  def home
    @artists = Artist.all
  end
end
