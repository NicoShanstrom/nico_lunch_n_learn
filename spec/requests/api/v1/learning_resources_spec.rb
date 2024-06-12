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

      it 'returns an empty video hash and empty image array when no content is found for country' do
          get "/api/v1/learning_resources?country=nocountryforoldmen", headers: { 'Content-Type': 'application/json', 'Accept': 'application/json' }

          expect(response).to have_http_status(:success)

          json_response = JSON.parse(response.body, symbolize_names: true)
          expect(json_response).to have_key(:data)

          data = json_response[:data]
          expect(data).to have_key(:id)
          expect(data[:id]).to be_nil
          expect(data).to have_key(:type)
          expect(data[:type]).to eq("learning_resource")
          expect(data).to have_key(:attributes)

          attributes = data[:attributes]
          expect(attributes).to have_key(:country)
          expect(attributes[:country]).to eq("nocountryforoldmen")
          expect(attributes).to have_key(:video)
          expect(attributes[:video]).to eq({})
          expect(attributes).to have_key(:images)
          expect(attributes[:images]).to eq([])
      end
    end
  end
end
