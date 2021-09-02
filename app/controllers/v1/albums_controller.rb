module V1
  class AlbumsController < ApplicationController
    def index
      @albums = Album.includes(:photos)
    end

    def show
      @album = Album.where(id: params[:id])
                    .includes(:photos)
                    .first
    end
  end
end
