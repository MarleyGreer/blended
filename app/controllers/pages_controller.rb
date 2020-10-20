class PagesController < ApplicationController

  def home
    @artists = Artist.all
    @recently_added = Artist.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
  end

end
