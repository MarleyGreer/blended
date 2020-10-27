class PagesController < ApplicationController

  def home
    @artists = Artist.all
    @recently_added = Artist.last(10)
  end

end
