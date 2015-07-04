require 'rails_helper'

describe "api group_events" do
  describe "GET /group_events" do
    it 'shows all group events' do
      @alpha = FactoryGirl.create(:group_event_alpha)
      @omega = FactoryGirl.create(:group_event_omega)
      
      get api_group_events_path

      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json.count).to eq(2)

      expect(json.first['id']).to                    eq(@alpha.id)
      expect(json.first['name']).to                  eq(@alpha.name)
      expect(json.first['state']).to                 eq(@alpha.state)
      expect(json.first['location']).to              eq(@alpha.location)
      expect(json.first['starts_at'].to_date).to     eq(@alpha.starts_at)
      expect(json.first['ends_at'].to_date).to       eq(@alpha.ends_at)
      expect(json.first['duration']).to              eq(@alpha.duration)
      expect(json.first['user_id']).to               eq(@alpha.user_id)
      expect(json.first['original_description']).to  eq(@alpha.original_description)
      expect(json.first['formatted_description']).to eq(@alpha.formatted_description)

      expect(json.last['id']).to                    eq(@omega.id)
      expect(json.last['name']).to                  eq(@omega.name)
      expect(json.last['state']).to                 eq(@omega.state)
      expect(json.last['location']).to              eq(@omega.location)
      expect(json.last['starts_at'].to_date).to     eq(@omega.starts_at)
      expect(json.last['ends_at'].to_date).to       eq(@omega.ends_at)
      expect(json.last['duration']).to              eq(@omega.duration)
      expect(json.last['user_id']).to               eq(@omega.user_id)
      expect(json.last['original_description']).to  eq(@omega.original_description)
      expect(json.last['formatted_description']).to eq(@omega.formatted_description)
    end
  end

  describe "GET /group_events/:id" do
    it 'shows required group event' do
      @group_event = FactoryGirl.create(:group_event)

      get api_group_event_path(@group_event)

      expect(response).to be_success
      json = JSON.parse(response.body)

      expect(json['id']).to                    eq(@group_event.id)
      expect(json['name']).to                  eq(@group_event.name)
      expect(json['state']).to                 eq(@group_event.state)
      expect(json['location']).to              eq(@group_event.location)
      expect(json['starts_at'].to_date).to     eq(@group_event.starts_at)
      expect(json['ends_at'].to_date).to       eq(@group_event.ends_at)
      expect(json['duration']).to              eq(@group_event.duration)
      expect(json['user_id']).to               eq(@group_event.user_id)
      expect(json['original_description']).to  eq(@group_event.original_description)
      expect(json['formatted_description']).to eq(@group_event.formatted_description)
    end
  end

  describe "POST /group_events" do
    it 'creates a new group event' do
      @group_event_attributes = FactoryGirl.attributes_for(:group_event)

      post api_group_events_path, group_event: @group_event_attributes

      expect(response).to be_success

      @group_event = GroupEvent.first

      expect(@group_event.name).to                  eq(@group_event_attributes[:name])
      expect(@group_event.location).to              eq(@group_event_attributes[:location])
      expect(@group_event.starts_at).to             eq(@group_event_attributes[:starts_at])
      expect(@group_event.ends_at).to               eq(@group_event_attributes[:ends_at])
      expect(@group_event.original_description).to  eq(@group_event_attributes[:original_description])
    end
  end

  describe "PATCH /group_events/:id" do
    it 'updates a required group event' do
      @alpha            = FactoryGirl.create(:group_event_alpha)
      @alpha_attributes = FactoryGirl.attributes_for(:group_event_alpha)
      @omega_attributes = FactoryGirl.attributes_for(:group_event_omega)

      patch api_group_event_path(@alpha), group_event: @omega_attributes

      expect(response).to be_success

      @alpha.reload
      expect(@alpha.name).to                 eq(@omega_attributes[:name])
      expect(@alpha.location).to             eq(@omega_attributes[:location])
      expect(@alpha.original_description).to eq(@omega_attributes[:original_description])
    end
  end

  describe "DELETE /group_events/:id" do
    it 'deletes a required group event' do
      @group_event = FactoryGirl.create(:group_event)

      delete api_group_event_path(@group_event)

      expect(response).to be_success
      
      @group_event.reload
      expect(@group_event.state).to eq('deleted')
    end
  end
  
end
