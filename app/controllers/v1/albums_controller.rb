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
        render json: { status: 'success' }
      else
        render json: { status: 'failed' }, status: :unprocessable_entity
      end
    end

    def update
      album = Album.find(params[:id])

      if album.update(album_params)
        render json: { status: 'success' }
      else
        render json: { status: 'failed' }, status: :unprocessable_entity
      end
    end

    def destroy
      album = Album.find(params[:id])

      if album.delete
        render json: { status: 'success' }
      else
        render json: { status: 'failed' }, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotFound
      render json: { status: 'failed' }, status: :unprocessable_entity
    end

    private

    def album_params
      params.permit(:name)
    end
  end
end
