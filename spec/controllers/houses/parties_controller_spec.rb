require 'rails_helper'

RSpec.describe Houses::PartiesController, vcr: true do

  describe "GET index" do
    before(:each) do
      get :index, params: { house_id: 'KL2k1BGP' }
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @house and @parties' do
      expect(assigns(:house)).to be_a(Grom::Node)
      expect(assigns(:house).type).to eq('http://id.ukpds.org/schema/House')

      assigns(:parties).each do |party|
        expect(party).to be_a(Grom::Node)
        expect(party.type).to eq('http://id.ukpds.org/schema/Party')
      end
    end

    it 'assigns @parties in alphabetical order' do
      expect(assigns(:parties)[0].name).to eq('partyName - 1')
      expect(assigns(:parties)[1].name).to eq('partyName - 10')
    end

    it 'renders the parties template' do
      expect(response).to render_template('index')
    end
  end

  describe "GET current_parties" do
    before(:each) do
      get :current_parties, params: { house_id: 'm1EgVTLj' }
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @house and @parties' do
      expect(assigns(:house)).to be_a(Grom::Node)
      expect(assigns(:house).type).to eq('http://id.ukpds.org/schema/House')
      assigns(:parties).each do |party|
        expect(party).to be_a(Grom::Node)
        expect(party.type).to eq('http://id.ukpds.org/schema/Party')
      end
    end

    it 'assigns @parties in member_count, then name order' do
      expect(assigns(:parties)[0].name).to eq('partyName - 3')
      expect(assigns(:parties)[1].name).to eq('partyName - 6')
      expect(assigns(:parties)[8].name).to eq('partyName - 10')
      expect(assigns(:parties)[8].member_count).to eq(2)
      expect(assigns(:parties)[9].name).to eq('partyName - 11')
      expect(assigns(:parties)[9].member_count).to eq(2)
    end

    it 'renders the current_parties template' do
      expect(response).to render_template('current_parties')
    end
  end

  describe "GET show" do
    context 'both house and party have a valid id' do
      before(:each) do
        get :show, params: { house_id: 'KL2k1BGP', party_id: 'P6LNyUn4' }
      end

      it 'should have a response with http status ok (200)' do
        expect(response).to have_http_status(:ok)
      end

      it 'assigns @house and @party' do
        expect(assigns(:house)).to be_a(Grom::Node)
        expect(assigns(:house).type).to eq('http://id.ukpds.org/schema/House')
        expect(assigns(:party)).to be_a(Grom::Node)
        expect(assigns(:party).type).to eq('http://id.ukpds.org/schema/Party')
      end

      it 'renders the party template' do
        expect(response).to render_template('show')
      end
    end

    context 'party id is invalid' do
      it 'raises an error if @party is nil' do
        house_id = 'KL2k1BGP'
        party_id = 'P6LNyUn5'

        expect{ get :show, params: { house_id: house_id, party_id: party_id } }.to raise_error(ActionController::RoutingError, 'Invalid party id')
      end
    end
  end
end
