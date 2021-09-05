# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::AlbumsController do
  let(:user) { FactoryBot.create(:user) }
  let(:token) { jwt_sign_in(email: user.email, password: user.password) }
  let(:headers) do
    { authorization: "JWT #{token}" }
  end
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

  context 'for viewing' do
    before do
      albums.each do |album|
        FactoryBot.create_list(:photo, 3, album: album)
      end
    end

    describe 'GET /albums' do
      let!(:albums) { FactoryBot.create_list(:album, 3) }
      let(:expected_body) { albums.as_json(json_format) }

      subject { get '/v1/albums', headers: headers }

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

      subject { get "/v1/albums/#{album.id}", headers: headers }

      it 'returns an album with photos' do
        subject
        expect(response.parsed_body).to include_json(expected_body)
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'POST /albums' do
    let(:name) { nil }
    subject { post "/v1/albums", params: { name: name }, headers: headers }

    context 'with valid name' do
      let(:name) { 'Albumi' }

      it 'returns success status' do
        subject
        expect(response.parsed_body).to eq('status' => 'success')
        expect(response.status).to eq(200)
      end

      it 'creates one album' do
        expect { subject }.to change { Album.where(name: name).count }.by(1)
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

  describe 'with existing record' do
    let(:album) { FactoryBot.create :album, name: 'Zippy' }

    describe 'PATCH /albums/:id' do
      let(:name) { nil }
      subject { patch "/v1/albums/#{album.id}", params: { name: name }, headers: headers }

      context 'with valid name' do
        let(:name) { 'Albumi' }

        it 'returns success status' do
          subject
          expect(response.parsed_body).to eq('status' => 'success')
          expect(response.status).to eq(200)
        end

        it 'creates one album' do
          expect { subject }.to change { Album.where(name: name).count }.by(1)
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

    describe 'DELETE /albums/:id' do
      subject { delete "/v1/albums/#{album_id}", headers: headers }

      context 'when successful' do
        let(:name) { 'Albumi' }
        let!(:album) { FactoryBot.create(:album, name: name) }
        let(:album_id) { album.id }

        it 'returns success status' do
          subject
          expect(response.parsed_body).to eq('status' => 'success')
          expect(response.status).to eq(200)
        end

        it 'deletes one album' do
          expect { subject }.to change { Album.where(name: name).count }.by(-1)
        end
      end

      context 'when it fails' do
        let(:album_id) { 9 }

        it 'returns failed status' do
          subject
          expect(response.parsed_body).to eq('status' => 'failed')
          expect(response.status).to eq(422)
        end
      end
    end
  end
end
