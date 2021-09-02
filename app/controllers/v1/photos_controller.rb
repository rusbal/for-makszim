module V1
  class PhotosController < ApplicationController
    def show
      @photo = Photo.find(params[:id])
    end

    def create
      photo = Photo.new(photo_params)

      if photo.save
        render json: { status: 'success' }
      else
        render json: { status: 'failed' }, status: :unprocessable_entity
      end
    end

    def update
      photo = Photo.find(params[:id])

      if photo.update(photo_params)
        render json: { status: 'success' }
      else
        render json: { status: 'failed' }, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotFound
      render json: { status: 'failed' }, status: :unprocessable_entity
    end

    def destroy
      album = Photo.find(params[:id])

      if album.delete
        render json: { status: 'success' }
      else
        render json: { status: 'failed' }, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotFound
      render json: { status: 'failed' }, status: :unprocessable_entity
    end

    private

    def photo_params
      params.permit(:name, :album_id)
    end
  end
end
