# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::AlbumsController do
  let(:json_format) do
    {
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
    }
  end

  before do
    albums.each do |album|
      FactoryBot.create_list(:photo, 3, album: album)
    end
  end

  describe 'GET /albums' do
    let!(:albums) { FactoryBot.create_list(:album, 3) }
    let(:expected_body) { albums.as_json(json_format) }

    subject { get '/v1/albums' }

    it 'returns a list of albums with photos' do
      subject
      expect(response.parsed_body).to include_json(expected_body)
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /albums/:id' do
    let!(:album) { FactoryBot.create(:album) }
    let(:albums) { [album] }
    let(:expected_body) { album.as_json(json_format) }

    subject { get "/v1/albums/#{album.id}" }

    it 'returns an album with photos' do
      subject
      expect(response.parsed_body).to include_json(expected_body)
      expect(response.status).to eq(200)
    end
  end
end
