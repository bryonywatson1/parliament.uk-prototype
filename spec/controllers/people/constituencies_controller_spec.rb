require 'rails_helper'

RSpec.describe People::ConstituenciesController, vcr: true do

  describe "GET index" do
    before(:each) do
      get :index, params: { person_id: '7TX8ySd4' }
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @person and @seat_incumbencies' do
      expect(assigns(:person)).to be_a(Grom::Node)
      expect(assigns(:person).type).to eq('http://id.ukpds.org/schema/Person')
      assigns(:seat_incumbencies).each do |seat_incumbency|
        expect(seat_incumbency).to be_a(Grom::Node)
        expect(seat_incumbency.type).to eq('http://id.ukpds.org/schema/SeatIncumbency')
      end
    end

    it 'assigns @seat_incumbencies in reverse chronological order' do
      expect(assigns(:seat_incumbencies)[0].start_date).to eq(DateTime.new(2015, 5, 7))
      expect(assigns(:seat_incumbencies)[1].start_date).to eq(DateTime.new(2010, 5, 6))
    end

    it 'renders the parties template' do
      expect(response).to render_template('index')
    end
  end

  describe "GET current_constituency" do
    before(:each) do
      get :current_constituency, params: { person_id: '7TX8ySd4' }
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @person and @constituency' do
      expect(assigns(:person)).to be_a(Grom::Node)
      expect(assigns(:person).type).to eq('http://id.ukpds.org/schema/Person')
      expect(assigns(:constituency)).to be_a(Grom::Node)
      expect(assigns(:constituency).type).to eq('http://id.ukpds.org/schema/ConstituencyGroup')
    end

    it 'renders the current_constituency template' do
      expect(response).to render_template('current_constituency')
    end
  end


end
