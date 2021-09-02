# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::PhotosController do
  let(:json_format) do
    {
      except: %i[
        created_at
        updated_at
      ]
    }
  end

  describe 'GET /photos/:id' do
    let!(:photo) { FactoryBot.create(:photo) }
    let(:expected_body) { photo.as_json(json_format) }

    subject { get "/v1/photos/#{photo.id}" }

    it 'returns a photo' do
      subject
      expect(response.parsed_body).to include_json(expected_body)
      expect(response.status).to eq(200)
    end
  end
end
