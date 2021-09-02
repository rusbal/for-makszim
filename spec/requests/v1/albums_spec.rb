# frozen_string_literal: true
require 'rails_helper'

RSpec.describe V1::AlbumsController do
  describe 'GET /albums' do
    let!(:albums) { FactoryBot.create_list(:album, 3) }
    let(:expected_body) do
      albums.as_json(
        include: {
          photos: { except: %i[
            album_id
            created_at
            updated_at
          ] }
        },
        except: %i[
          created_at
          updated_at
        ]
      )
    end

    before do
      albums.each do |album|
        FactoryBot.create_list(:photo, 3, album: album)
      end
    end

    subject { get '/v1/albums' }

    it 'returns a list of albums with photos' do
      subject
      expect(response.parsed_body).to include_json(expected_body)
      expect(response.status).to eq(200)
    end
  end
end