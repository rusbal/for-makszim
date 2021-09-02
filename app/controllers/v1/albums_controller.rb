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
      album = Album.new(name: params[:name])

      if album.save
        render json: { status: 'success' }
      else
        render json: { status: 'failed' }, status: :unprocessable_entity
      end
    end
  end
end
