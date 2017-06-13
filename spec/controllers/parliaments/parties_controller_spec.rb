require 'rails_helper'

RSpec.describe Parliaments::PartiesController, vcr: true do

  describe 'GET parties' do
    before(:each) do
      get :parties, params: { parliament_id: 'GEFMX81E' }
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

    context '@parties' do
      it 'assigns @parties' do
        assigns(:parties).each do |party|
          expect(party).to be_a(Grom::Node)
          expect(party.type).to eq('http://id.ukpds.org/schema/Party')
        end
      end

      it 'assigns @parties in member count then name order' do
        expect(assigns(:parties)[0].name).to eq('partyName - 11')
        expect(assigns(:parties)[0].member_count).to eq(333)
        expect(assigns(:parties)[1].name).to eq('partyName - 1')
        expect(assigns(:parties)[1].member_count).to eq(240)
        expect(assigns(:parties)[10].name).to eq('partyName - 3')
        expect(assigns(:parties)[10].member_count).to eq(1)
        expect(assigns(:parties)[11].name).to eq('partyName - 4')
        expect(assigns(:parties)[11].member_count).to eq(1)
        expect(assigns(:parties)[12].name).to eq('partyName - 7')
        expect(assigns(:parties)[12].member_count).to eq(1)
      end
    end

    it 'renders the parties template' do
      expect(response).to render_template('parties')
    end
  end

  describe 'GET party' do
    context '@party is nil' do
      # updated VCR cassette in order to set @party to nil
      it 'should raise ActionController::RoutingError' do
        expect{get :party, params: { parliament_id: '0FxbTVtr', party_id: 'P6LNyUn4' }}.to raise_error(ActionController::RoutingError)
      end
    end

    context '@party is not nil' do
      before(:each) do
        get :party, params: { parliament_id: '0FxbTVtr', party_id: 'P6LNyUn4' }
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

      context '@party' do
        it 'assigns @party' do
          expect(assigns(:party)).to be_a(Grom::Node)
          expect(assigns(:party).type).to eq('http://id.ukpds.org/schema/Party')
        end
      end

      it 'renders the party template' do
        expect(response).to render_template('party')
      end
    end
  end

  describe 'GET party_members' do
    before(:each) do
      get :party_members, params: { parliament_id: '0FxbTVtr', party_id: 'P6LNyUn4' }
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

    it 'renders the party_members template' do
      expect(response).to render_template('party_members')
    end
  end

  describe 'GET a_to_z_party_members' do
    before(:each) do
      get :a_to_z_party_members, params: { parliament_id: '0FxbTVtr', party_id: 'P6LNyUn4' }
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

    it 'renders the a_to_z_party_members template' do
      expect(response).to render_template('a_to_z_party_members')
    end
  end

  describe 'GET party_members_letters' do
    before(:each) do
      get :party_members_letters, params: { parliament_id: 'GEFMX81E', party_id: 'lk3RZ8EB', letter: 'a' }
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
    end
  end

end
