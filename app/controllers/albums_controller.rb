class AlbumsController < ApplicationController
  before_action :require_login

  def create
    album = Album.new(album_params)
    if album.save
      redirect_to album_url(album)
    else
      redirect_to :back
    end
  end

  def edit
    @album = Album.find(params[:id])
  end

  def update
    album = Album.find(params[:id])
    if album.update(album_params)
      redirect_to album_url(album)
    else
      redirect_to edit_album_url(album)
    end
  end

  def show
    @album = Album.find(params[:id])
  end

  def new
    @album = Album.new
  end

  def destroy
    album = Album.find(params[:id])
    band_id = album.band_id
    album.destroy
    redirect_to band_url(band_id)
  end

  private

  def album_params
    params.require(:album).permit(:title, :album_type, :band_id)
  end
end
