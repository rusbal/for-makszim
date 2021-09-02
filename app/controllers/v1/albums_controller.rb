module V1
  class AlbumsController < ApplicationController
    def index
      @albums = Album.includes(:photos)
    end
  end
end
