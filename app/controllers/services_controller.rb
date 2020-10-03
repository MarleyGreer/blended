class ServicesController < ApplicationController
  def index
    @artist = Artist.find(params[:artist_id])
    @services = @artist.services
  end

  def new
    @artist = Artist.find(params[:artist_id])
    @service = Service.new
  end

  def create
    @artist = Artist.find(params[:artist_id])
    @service = Service.new(service_params)
    @service.artist = @artist

    if @service.save
      redirect_to artist_services_path(@artist)
    else
      render :new
    end
  end

  def edit
    @service = Service.find(params[:id])
  end

  def update
    @service = Service.find(params[:id])
    @service.update(service_params)
    @artist = @service.artist
    redirect_to artist_services_path(@artist)
  end

  def destroy
    @service = Service.find(params[:id])
    @artist = @service.artist
    @service.destroy
    redirect_to artist_services_path(@artist)
  end

 private

  def service_params
    params.require(:service).permit(:name, :description, :price, :duration)
  end
end
