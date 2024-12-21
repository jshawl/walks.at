class BookmarksController < ApplicationController
  def create
    bookmark = current_user.bookmarks.create!(bookmark_params)
    redirect_to explore_events_path(bookmark: bookmark.id)
  end

  def update
    bookmark = current_user.bookmarks.find(params[:id])
    bookmark.update!(bookmark_params)
    redirect_to explore_events_path(bookmark: bookmark.id)
  end

  def destroy
    bookmark = current_user.bookmarks.find(params[:id])
    bookmark.destroy!
    redirect_to explore_events_path
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:name, :northeast_latitude, :northeast_longitude, :southwest_latitude,
                                     :southwest_longitude)
  end
end
