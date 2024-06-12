# spec/requests/api/v1/learning_resources_spec.rb
require 'rails_helper'

RSpec.describe "Learning Resources API", type: :request do
  describe "GET /api/v1/learning_resources" do
    describe "when country parameter is provided" do
      it 'returns learning resources for the specified country', :vcr do
        get "/api/v1/learning_resources?country=laos", headers: { 'Content-Type': 'application/json', 'Accept': 'application/json' }

        expect(response).to have_http_status(:success)

        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(json_response).to have_key(:data)
        expect(json_response[:data]).to have_key(:id)
        expect(json_response[:data]).to have_key(:type)
        expect(json_response[:data]).to have_key(:attributes)

        attributes = json_response[:data][:attributes]
        expect(attributes).to have_key(:country)
        expect(attributes).to have_key(:video)
        expect(attributes).to have_key(:images)

        video = attributes[:video]
        expect(video).to have_key(:title)
        expect(video).to have_key(:youtube_video_id)
        expect(video).to_not have_key(:thumbmnails)

        images = attributes[:images]
        expect(images).to be_an(Array)
        images.each do |image|
          expect(image).to have_key(:alt_tag)
          expect(image).to have_key(:url)
          expect(image).to_not have_key(:likes)
        end
      end
    end

    describe "when no country parameter is provided" do
      it 'returns an error', :vcr do
        get "/api/v1/learning_resources", headers: { 'Content-Type': 'application/json', 'Accept': 'application/json' }

        expect(response).to have_http_status(:bad_request)
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(json_response).to have_key(:error)
      end
    end
  end
end
