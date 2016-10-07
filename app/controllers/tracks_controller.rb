class TracksController < ApplicationController
  before_action :require_login

  def create
    track = Track.new(track_params)
    p "hello"
    if track.save
      p "hello"
      redirect_to track_url(track)
    else
      flash[:errors] = track.errors
      redirect_to new_album_track_url
    end
  end

  def update
    track = Track.find(params[:id])
    if track.update(track_params)
      redirect_to track_url(track)
    else
      flash[:errors] = track.errors
      redirect_to edit_track_url(track)
    end
  end

  def show
    @track = Track.find(params[:id])
  end

  def edit
    @track = Track.find(params[:id])
  end

  def new
    @track = Track.new
  end

  def destroy
    track = Track.find(params[:id])
    album_id = track.album_id
    track.destroy
    redirect_to album_url(album_id)
  end

  private

  def track_params
    params.require(:track).permit(:lyrics, :song, :track_type, :album_id)
  end
end
