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
    note.save
    redirect_to track_url(params[:track_id])
  end

  def update
    note = Note.find(params[:id])
    if note.update(note_params)
      redirect_to track_url(note.track_id)
    else
      flash[:errors] = note.errors
      redirect_to edit_note(params[:id])
    end
  end

  def destroy
    note = Note.find(params[:id])
    if note.user_id == current_user.id
      track_id = note.track_id
      note.destroy
      redirect_to track_url(track_id)
    else
      render status: :forbidden
    end
  end

  private

  def note_params
    params.require(:note).permit(:comment)
  end
end
