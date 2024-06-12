# spec/services/youtube_service_spec.rb
require 'rails_helper'

RSpec.describe YoutubeService, type: :service do
  describe '.search', :vcr do
    describe 'when a valid country name is provided' do
      it 'returns video details' do
        response = YoutubeService.search('laos')

        expect(response).to be_a(Hash)
        expect(response).to have_key(:title)
        expect(response).to have_key(:youtube_video_id)
        expect(response).to_not have_key(:thumbmnails)
      end
    end

    describe 'when an invalid country name is provided' do
      it 'returns an empty hash' do
        response = YoutubeService.search('invalidcountryname')

        expect(response).to eq({})
        expect(response).to_not eq(nil)
      end
    end
  end
end
