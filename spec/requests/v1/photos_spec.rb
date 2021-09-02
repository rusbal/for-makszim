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

  describe 'POST /photos' do
    let(:name) { nil }
    let(:album) { FactoryBot.create :album }
    subject { post "/v1/photos", params: { name: name, album_id: album.id } }

    context 'with valid name' do
      let(:name) { 'Phototi' }

      it 'returns success status' do
        subject
        expect(response.parsed_body).to eq('status' => 'success')
        expect(response.status).to eq(200)
      end

      it 'creates one photo' do
        expect { subject }.to change { Photo.where(name: name).count }.by(1)
      end
    end

    context 'with invalid name' do
      it 'returns failed status' do
        subject
        expect(response.parsed_body).to eq('status' => 'failed')
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'PATCH /photos/:id' do
    let(:album) { FactoryBot.create :photo, name: 'Yellow' }
    let(:name) { nil }
    subject { patch "/v1/photos/#{album.id}", params: { name: name } }

    context 'with valid name' do
      let(:name) { 'Phototi' }

      it 'returns success status' do
        subject
        expect(response.parsed_body).to eq('status' => 'success')
        expect(response.status).to eq(200)
      end

      it 'creates one album' do
        expect { subject }.to change { Photo.where(name: name).count }.by(1)
      end
    end

    context 'with invalid name' do
      it 'returns failed status' do
        subject
        expect(response.parsed_body).to eq('status' => 'failed')
        expect(response.status).to eq(422)
      end
    end
  end
end
