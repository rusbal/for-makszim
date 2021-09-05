# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::UsersController do
  let(:user) { FactoryBot.create(:user) }
  let(:token) { jwt_sign_in(email: user.email, password: user.password) }
  let(:headers) do
    { authorization: "JWT #{token}" }
  end
  let(:json_format) do
    {
      except: %i[
        created_at
        updated_at
      ]
    }
  end

  context 'for viewing' do
    describe 'GET /users' do
      let!(:users) { FactoryBot.create_list(:user, 3) }
      let(:expected_body) { users.as_json(json_format) }

      subject { get '/v1/users', headers: headers }

      it 'returns a list of users' do
        subject
        expect(response.parsed_body).to include_json(expected_body)
        expect(response.status).to eq(200)
      end
    end

    describe 'GET /users/:id' do
      let!(:user) { FactoryBot.create(:user) }
      let(:users) { [user] }
      let(:expected_body) { user.as_json(json_format) }

      subject { get "/v1/users/#{user.id}", headers: headers }

      it 'returns an user' do
        subject
        expect(response.parsed_body).to include_json(expected_body)
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'with existing record' do
    let(:user) { FactoryBot.create :user, first_name: 'Zippy' }

    describe 'PATCH /users/:id' do
      let(:first_name) { nil }
      subject { patch "/v1/users/#{user.id}", params: { first_name: first_name }, headers: headers }

      context 'with valid first_name' do
        let(:first_name) { 'Useri' }

        it 'returns success status' do
          subject
          expect(response.parsed_body).to eq('status' => 'success')
          expect(response.status).to eq(200)
        end

        it 'creates one user' do
          expect { subject }.to change { User.where(first_name: first_name).count }.by(1)
        end
      end
    end

    describe 'DELETE /users/:id' do
      subject { delete "/v1/users/#{user_id}", headers: headers }

      context 'when successful' do
        let(:first_name) { 'Useri' }
        let!(:user) { FactoryBot.create(:user, first_name: first_name) }
        let(:user_id) { user.id }

        it 'returns success status' do
          subject
          expect(response.parsed_body).to eq('status' => 'success')
          expect(response.status).to eq(200)
        end

        it 'deletes one user' do
          expect { subject }.to change { User.where(first_name: first_name).count }.by(-1)
        end
      end

      context 'when it fails' do
        let(:user_id) { 9 }

        it 'returns failed status' do
          subject
          expect(response.parsed_body).to eq('status' => 'failed')
          expect(response.status).to eq(422)
        end
      end
    end
  end
end
