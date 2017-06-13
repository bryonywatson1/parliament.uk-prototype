require 'rails_helper'

RSpec.describe Parliaments::ConstituenciesController, vcr: true do
  describe 'GET constituencies' do
    before(:each) do
      get :constituencies, params: { parliament_id: '0FxbTVtr' }
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

    context '@constituencies' do
      it 'assigns @constituencies' do
        assigns(:constituencies).each do |constituency|
          expect(constituency).to be_a(Grom::Node)
          expect(constituency.type).to eq('http://id.ukpds.org/schema/ConstituencyGroup')
        end
      end
    end

    it 'renders the constituencies template' do
      expect(response).to render_template('constituencies')
    end
  end

  describe 'GET a_to_z_constituencies' do
    before(:each) do
      get :a_to_z_constituencies, params: { parliament_id: '0FxbTVtr' }
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

    context '@constituencies' do
      it 'assigns @constituencies' do
        assigns(:constituencies).each do |constituency|
          expect(constituency).to be_a(Grom::Node)
          expect(constituency.type).to eq('http://id.ukpds.org/schema/ConstituencyGroup')
        end
      end
    end

    it 'renders the constituencies template' do
      expect(response).to render_template('a_to_z_constituencies')
    end
  end

  describe 'GET constituencies_letters' do
    before(:each) do
      get :constituencies_letters, params: { parliament_id: '0FxbTVtr', letter: 'a' }
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    context '@constituencies' do
      it 'assigns @constituencies' do
        assigns(:constituencies).each do |constituency|
          expect(constituency).to be_a(Grom::Node)
          expect(constituency.type).to eq('http://id.ukpds.org/schema/ConstituencyGroup')
        end
      end
    end

    context '@letters' do
      it 'assigns @letters' do
        expect(assigns(:letters)).to be_a(Array)
      end
    end
  end

end
