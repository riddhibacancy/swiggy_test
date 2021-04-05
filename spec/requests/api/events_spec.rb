require 'rails_helper'

RSpec.describe "Events" do
  describe "POST /api/events with proper data" do
    before do
      repo = create(:repo, name: Faker::Name.first_name)
      actor = create(:actor, name: Faker::Name.first_name)

      post '/api/events', params: { repo_id: repo.id, actor_id: actor.id,
        public: true, event_type: 'PushEvent' }
    end

    it 'returns a created status' do
      expect(response).to have_http_status(201)
    end

    it 'returns the event_type' do
      expect(JSON.parse(response.body)['event_type']).to eq('PushEvent')
    end
  end

  describe "POST /api/events with improper data" do
    before do
      repo = create(:repo, name: Faker::Name.first_name)
      actor = create(:actor, name: Faker::Name.first_name)

      post '/api/events', params: { repo_id: repo.id, actor_id: actor.id,
        public: true, event_type: 'NewPushEvent' }
    end

    it 'not create company if invalid event_type' do
      expect(response).to have_http_status(400)
    end
  end

  describe "GET /api/events with proper data" do
    let!(:events) { FactoryBot.create_list(:event) }
    before { get '/api/v1/companies', as: :json }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
