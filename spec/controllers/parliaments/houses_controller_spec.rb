require 'rails_helper'

RSpec.describe Parliaments::HousesController, vcr: true do

  describe 'GET houses' do
    before(:each) do
      get :houses, params: { parliament_id: '0FxbTVtr' }
    end

    it 'should have a response with http status ok (200)'do
      expect(response).to have_http_status(:ok)
    end

    context '@parliament' do
      it 'assigns @parliament' do
        expect(assigns(:parliament)).to be_a(Grom::Node)
        expect(assigns(:parliament).type).to eq('http://id.ukpds.org/schema/ParliamentPeriod')
      end
    end

    context '@house' do
      it 'assigns @houses' do
        assigns(:houses).each do |house|
          expect(house).to be_a(Grom::Node)
          expect(house.type).to eq('http://id.ukpds.org/schema/House')
        end
      end
    end

    it 'renders the houses template' do
      expect(response).to render_template('houses')
    end
  end

  describe 'GET house' do
    context '@house is nil' do
      # updated VCR cassette in order to set @house to nil
      it 'should raise ActionController::RoutingError' do
        expect{get :house, params: { parliament_id: '0FxbTVtr', house_id: 'cqIATgUK' }}.to raise_error(ActionController::RoutingError)
      end
    end

    context '@house is not nil' do
      before(:each) do
        get :house, params: { parliament_id: '0FxbTVtr', house_id: 'cqIATgUK' }
      end

      context '@parliament' do
        it 'assigns @parliament' do
          expect(assigns(:parliament)).to be_a(Grom::Node)
          expect(assigns(:parliament).type).to eq('http://id.ukpds.org/schema/ParliamentPeriod')
        end
      end

      context '@house' do
        it 'assigns @house' do
          expect(assigns(:house)).to be_a(Grom::Node)
          expect(assigns(:house).type).to eq('http://id.ukpds.org/schema/House')
        end
      end

      it 'renders the house template' do
        expect(response).to render_template('house')
      end
    end
  end

  describe 'GET house_members' do
    before(:each) do
      get :house_members, params: { parliament_id: '0FxbTVtr', house_id: 'cqIATgUK' }
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    context '@parliament' do
      it 'assigns @parliament' do
        expect(assigns(:parliament)).to be_a(Grom::Node)
        expect(assigns(:parliament).type).to eq('http://id.ukpds.org/schema/ParliamentPeriod')
      end
    end

    context '@house' do
      it 'assigns @house' do
        expect(assigns(:house)).to be_a(Grom::Node)
        expect(assigns(:house).type).to eq('http://id.ukpds.org/schema/House')
      end
    end

    context '@people' do
      it 'assigns @people' do
        assigns(:people).each do |person|
          expect(person).to be_a(Grom::Node)
          expect(person.type).to eq('http://id.ukpds.org/schema/Person')
        end
      end

      it 'assigns @people in alphabetical order' do
        expect(assigns(:people)[0].given_name).to eq('personGivenName - 1')
        expect(assigns(:people)[1].given_name).to eq('personGivenName - 2')
      end
    end

    it 'renders the house template' do
      expect(response).to render_template('house_members')
    end
  end

  describe 'GET a_to_z_house_members' do
    before(:each) do
      get :a_to_z_house_members, params: { parliament_id: '0FxbTVtr', house_id: 'cqIATgUK' }
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    context '@parliament' do
      it 'assigns @parliament' do
        expect(assigns(:parliament)).to be_a(Grom::Node)
        expect(assigns(:parliament).type).to eq('http://id.ukpds.org/schema/ParliamentPeriod')
      end
    end

    context '@house' do
      it 'assigns @house' do
        expect(assigns(:house)).to be_a(Grom::Node)
        expect(assigns(:house).type).to eq('http://id.ukpds.org/schema/House')
      end
    end

    context '@letters' do
      it 'assigns @letters' do
        expect(assigns(:letters)).to be_a(Array)
      end
    end

    it 'renders the house a-z template' do
      expect(response).to render_template('a_to_z_house_members')
    end
  end

  describe 'GET house_members_letters' do
    before(:each) do
      get :house_members_letters, params: { parliament_id: '0FxbTVtr', house_id: 'cqIATgUK', letter: 'a' }
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    context '@parliament' do
      it 'assigns @parliament' do
        expect(assigns(:parliament)).to be_a(Grom::Node)
        expect(assigns(:parliament).type).to eq('http://id.ukpds.org/schema/ParliamentPeriod')
      end
    end

    context '@house' do
      it 'assigns @house' do
        expect(assigns(:house)).to be_a(Grom::Node)
        expect(assigns(:house).type).to eq('http://id.ukpds.org/schema/House')
      end
    end

    context '@people' do
      it 'assigns @people' do
        assigns(:people).each do |person|
          expect(person).to be_a(Grom::Node)
          expect(person.type).to eq('http://id.ukpds.org/schema/Person')
        end
      end

      it 'assigns @people in alphabetical order' do
        expect(assigns(:people)[0].given_name).to eq('personGivenName - 1')
        expect(assigns(:people)[1].given_name).to eq('personGivenName - 2')
      end
    end

    context '@letters' do
      it 'assigns @letters' do
        expect(assigns(:letters)).to be_a(Array)
      end
    end

    it 'renders the house template' do
      expect(response).to render_template('house_members_letters')
    end
  end

  describe 'GET house_parties' do
    before(:each) do
      get :house_parties, params: { parliament_id: '0FxbTVtr', house_id: 'cqIATgUK' }
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    context '@parliament' do
      it 'assigns @parliament' do
        expect(assigns(:parliament)).to be_a(Grom::Node)
        expect(assigns(:parliament).type).to eq('http://id.ukpds.org/schema/ParliamentPeriod')
      end
    end

    context '@house' do
      it 'assigns @house' do
        expect(assigns(:house)).to be_a(Grom::Node)
        expect(assigns(:house).type).to eq('http://id.ukpds.org/schema/House')
      end
    end

    context '@parties' do
      it 'assigns @parties' do
        assigns(:parties).each do |person|
          expect(person).to be_a(Grom::Node)
          expect(person.type).to eq('http://id.ukpds.org/schema/Party')
        end
      end

      it 'assigns @parties in alphabetical order' do
        expect(assigns(:parties)[0].name).to eq('partyName - 1')
        expect(assigns(:parties)[1].name).to eq('partyName - 10')
      end
    end

    it 'renders the house template' do
      expect(response).to render_template('house_parties')
    end
  end

  describe 'GET house_party' do
    context '@party is nil' do
      # updated VCR cassette in order to set @party to nil
      it 'should raise ActionController::RoutingError' do
        expect{get :house_party, params: { parliament_id: '0FxbTVtr', house_id: 'cqIATgUK', party_id: 'P6LNyUn4' }}.to raise_error(ActionController::RoutingError)
      end
    end

    context '@party is not nil' do
      before(:each) do
        get :house_party, params: { parliament_id: '0FxbTVtr', house_id: 'cqIATgUK', party_id: 'P6LNyUn4' }
      end

      it 'should have a response with http status ok (200)' do
        expect(response).to have_http_status(:ok)
      end

      context '@parliament' do
        it 'assigns @parliament' do
          expect(assigns(:parliament)).to be_a(Grom::Node)
          expect(assigns(:parliament).type).to eq('http://id.ukpds.org/schema/ParliamentPeriod')
        end
      end

      context '@house' do
        it 'assigns @house' do
          expect(assigns(:house)).to be_a(Grom::Node)
          expect(assigns(:house).type).to eq('http://id.ukpds.org/schema/House')
        end
      end

      context '@party' do
        it 'assigns @party' do
          expect(assigns(:party)).to be_a(Grom::Node)
          expect(assigns(:party).type).to eq('http://id.ukpds.org/schema/Party')
        end
      end

      it 'renders the house template' do
        expect(response).to render_template('house_party')
      end
    end
  end

  describe 'GET house_party_members' do
    before(:each) do
      get :house_party_members, params: { parliament_id: '0FxbTVtr', house_id: 'cqIATgUK', party_id: 'P6LNyUn4' }
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    context '@parliament' do
      it 'assigns @parliament' do
        expect(assigns(:parliament)).to be_a(Grom::Node)
        expect(assigns(:parliament).type).to eq('http://id.ukpds.org/schema/ParliamentPeriod')
      end
    end

    context '@house' do
      it 'assigns @house' do
        expect(assigns(:house)).to be_a(Grom::Node)
        expect(assigns(:house).type).to eq('http://id.ukpds.org/schema/House')
      end
    end

    context '@party' do
      it 'assigns @party' do
        expect(assigns(:party)).to be_a(Grom::Node)
        expect(assigns(:party).type).to eq('http://id.ukpds.org/schema/Party')
      end
    end

    context '@people' do
      it 'assigns @people' do
        assigns(:people).each do |person|
          expect(person).to be_a(Grom::Node)
          expect(person.type).to eq('http://id.ukpds.org/schema/Person')
        end
      end

      it 'assigns @people in alphabetical order' do
        expect(assigns(:people)[0].given_name).to eq('personGivenName - 101')
        expect(assigns(:people)[1].given_name).to eq('personGivenName - 105')
      end
    end

    it 'renders the house template' do
      expect(response).to render_template('house_party_members')
    end
  end

  describe 'GET a_to_z_house_party_members' do
    before(:each) do
      get :a_to_z_house_party_members, params: { parliament_id: '0FxbTVtr', house_id: 'cqIATgUK', party_id: 'P6LNyUn4' }
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    context '@parliament' do
      it 'assigns @parliament' do
        expect(assigns(:parliament)).to be_a(Grom::Node)
        expect(assigns(:parliament).type).to eq('http://id.ukpds.org/schema/ParliamentPeriod')
      end
    end

    context '@house' do
      it 'assigns @house' do
        expect(assigns(:house)).to be_a(Grom::Node)
        expect(assigns(:house).type).to eq('http://id.ukpds.org/schema/House')
      end
    end

    context '@party' do
      it 'assigns @party' do
        expect(assigns(:party)).to be_a(Grom::Node)
        expect(assigns(:party).type).to eq('http://id.ukpds.org/schema/Party')
      end
    end

    context '@letters' do
      it 'assigns @letters' do
        expect(assigns(:letters)).to be_a(Array)
      end
    end

    it 'renders the house template' do
      expect(response).to render_template('a_to_z_house_party_members')
    end
  end

  describe 'GET house_party_members_letters' do
    before(:each) do
      get :house_party_members_letters, params: { parliament_id: 'GEFMX81E', house_id: 'cqIATgUK', party_id: 'lk3RZ8EB', letter: 'a' }
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    context '@parliament' do
      it 'assigns @parliament' do
        expect(assigns(:parliament)).to be_a(Grom::Node)
        expect(assigns(:parliament).type).to eq('http://id.ukpds.org/schema/ParliamentPeriod')
      end
    end

    context '@house' do
      it 'assigns @house' do
        expect(assigns(:house)).to be_a(Grom::Node)
        expect(assigns(:house).type).to eq('http://id.ukpds.org/schema/House')
      end
    end

    context '@party' do
      it 'assigns @party' do
        expect(assigns(:party)).to be_a(Grom::Node)
        expect(assigns(:party).type).to eq('http://id.ukpds.org/schema/Party')
      end
    end

    context '@people' do
      it 'assigns @people' do
        assigns(:people).each do |person|
          expect(person).to be_a(Grom::Node)
          expect(person.type).to eq('http://id.ukpds.org/schema/Person')
        end
      end

      it 'assigns @people in alphabetical order' do
        expect(assigns(:people)[0].given_name).to eq('personGivenName - 1')
        expect(assigns(:people)[1].given_name).to eq('personGivenName - 2')
      end
    end

    context '@letters' do
      it 'assigns @letters' do
        expect(assigns(:letters)).to be_a(Array)
      end
    end

    it 'renders the house template' do
      expect(response).to render_template('house_party_members_letters')
    end
  end
end
