require 'rails_helper'

RSpec.describe Parties::MembersController, vcr: true do

  describe 'GET index' do
    before(:each) do
      get :index, params: { party_id: 'lk3RZ8EB' }
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @party, @people and @letters' do
      expect(assigns(:party)).to be_a(Grom::Node)
      expect(assigns(:party).type).to eq('http://id.ukpds.org/schema/Party')
      expect(assigns(:letters)).to be_a(Array)

      assigns(:people).each do |person|
        expect(person).to be_a(Grom::Node)
        expect(person.type).to eq('http://id.ukpds.org/schema/Person')
      end
    end

    it 'assigns @people in alphabetical order' do
      expect(assigns(:people)[0].given_name).to eq('personGivenName - 1')
      expect(assigns(:people)[1].given_name).to eq('personGivenName - 10')
    end

    it 'renders the members template' do
      expect(response).to render_template('index')
    end
  end

  describe 'GET current members' do
    before(:each) do
      get :current_members, params: { party_id: 'lk3RZ8EB' }
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @party, @people and @letters' do
      expect(assigns(:party)).to be_a(Grom::Node)
      expect(assigns(:party).type).to eq('http://id.ukpds.org/schema/Party')
      expect(assigns(:letters)).to be_a(Array)

      assigns(:people).each do |person|
        expect(person).to be_a(Grom::Node)
        expect(person.type).to eq('http://id.ukpds.org/schema/Person')
      end
    end

    it 'assigns @people in alphabetical order' do
      expect(assigns(:people)[0].given_name).to eq('personGivenName - 1')
      expect(assigns(:people)[1].given_name).to eq('personGivenName - 10')
    end

    it 'renders the current_members template' do
      expect(response).to render_template('current_members')
    end
  end

  describe 'GET members_letters' do
    before(:each) do
      get :members_letters, params: { party_id: 'lk3RZ8EB', letter: 'a' }
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @party, @people and @letters' do
      expect(assigns(:party)).to be_a(Grom::Node)
      expect(assigns(:party).type).to eq('http://id.ukpds.org/schema/Party')
      expect(assigns(:letters)).to be_a(Array)

      assigns(:people).each do |person|
        expect(person).to be_a(Grom::Node)
        expect(person.type).to eq('http://id.ukpds.org/schema/Person')
      end
    end

    it 'assigns @people in alphabetical order' do
      expect(assigns(:people)[0].sort_name).to eq('A5EE13ABE03C4D3A8F1A274F57097B6C - 1')
      expect(assigns(:people)[1].sort_name).to eq('A5EE13ABE03C4D3A8F1A274F57097B6C - 11')
    end

    it 'renders the members_letters template' do
      expect(response).to render_template('members_letters')
    end
  end

  describe 'GET current_members_letters' do
    before(:each) do
      get :current_members_letters, params: { party_id: 'lk3RZ8EB', letter: 'c' }
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @party, @people and @letters' do
      expect(assigns(:party)).to be_a(Grom::Node)
      expect(assigns(:party).type).to eq('http://id.ukpds.org/schema/Party')
      expect(assigns(:letters)).to be_a(Array)

      assigns(:people).each do |person|
        expect(person).to be_a(Grom::Node)
        expect(person.type).to eq('http://id.ukpds.org/schema/Person')
      end
    end

    it 'assigns @people in alphabetical order' do
      expect(assigns(:people)[0].sort_name).to eq('A5EE13ABE03C4D3A8F1A274F57097B6C - 1')
      expect(assigns(:people)[1].sort_name).to eq('A5EE13ABE03C4D3A8F1A274F57097B6C - 10')
    end

    it 'renders the current_members_letters template' do
      expect(response).to render_template('current_members_letters')
    end
  end

  describe "GET a_to_z_members" do
    before(:each) do
      get :a_to_z_members, params: { party_id: 'P6LNyUn4' }
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @letters' do
      expect(assigns(:letters)).to be_a(Array)
    end

    it 'renders the a_to_z_members template' do
      expect(response).to render_template('a_to_z_members')
    end
  end

  describe "GET a_to_z_current_members" do
    before(:each) do
      get :a_to_z_current_members, params: { party_id: 'P6LNyUn4' }
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @letters' do
      expect(assigns(:letters)).to be_a(Array)
    end

    it 'renders the a_to_z_current_members template' do
      expect(response).to render_template('a_to_z_current_members')
    end
  end

  # Test for ApplicationController Parliament::NoContentResponseError handling
  describe 'rescue_from Parliament::ClientError' do
    it 'raises an ActionController::RoutingError' do
      expect{ get :index, params: { party_id: '12345678' } }.to raise_error(ActionController::RoutingError)
    end
  end

end
