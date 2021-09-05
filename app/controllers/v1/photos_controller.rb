module V1
  class PhotosController < ApplicationController
    before_action :authenticate_user

    def show
      @photo = Photo.find(params[:id])
    end

    def create
      photo = Photo.new(photo_params)

      if photo.save
        success
      else
        failure
      end
    end

    def update
      photo = Photo.find(params[:id])

      if photo.update(photo_params)
        success
      else
        failure
      end
    rescue ActiveRecord::RecordNotFound
      failure
    end

    def destroy
      album = Photo.find(params[:id])

      if album.delete
        success
      else
        failure
      end
    rescue ActiveRecord::RecordNotFound
      failure
    end

    private

    def photo_params
      params.permit(:name, :album_id)
    end
  end
end
