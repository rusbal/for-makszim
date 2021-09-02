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

    def create
      album = Album.new(album_params)

      if album.save
        success
      else
        failure
      end
    end

    def update
      album = Album.find(params[:id])

      if album.update(album_params)
        success
      else
        failure
      end
    rescue ActiveRecord::RecordNotFound
      failure
    end

    def destroy
      album = Album.find(params[:id])

      if album.delete
        success
      else
        failure
      end
    rescue ActiveRecord::RecordNotFound
      failure
    end

    private

    def album_params
      params.permit(:name)
    end
  end
end
