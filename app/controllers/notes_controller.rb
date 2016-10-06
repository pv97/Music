class NotesController < ApplicationController
  def new
    @note = Note.new
  end

  def show
    @note = Note.find(params[:id])
  end

  def create
    note = Note.create(note_params)
    note.user_id = current_user.id
    note.track_id = params[:track_id]
    if note.save
      redirect_to track_url(params[:track_id])
    else
      redirect_to new_track_note(params[:track_id])
    end
  end

  def update
    note = Note.find(params[:id])
    if note.update(note_params)
      redirect_to track_url(params[:track_id])
    else
      redirect_to edit_note(params[:id])
    end
  end

  def destroy
    note = Note.find(params[:id])
    track_id = note.track_id
    note.destroy
    redirect_to track_url(track_id)
  end

  private

  def note_params
    params.require(:note).permit(:comment)
  end
end
