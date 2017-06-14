require 'rails_helper'

RSpec.describe Constituencies::MembersController, vcr: true do

  describe 'GET index' do
    before(:each) do
      get :index, params: { constituency_id: 'vTNSMo38' }
    end

    it 'should have a response with a http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @constituency, @seat_incumbencies and @current_incumbency' do
      expect(assigns(:constituency)).to be_a(Grom::Node)
      expect(assigns(:constituency).type).to eq('http://id.ukpds.org/schema/ConstituencyGroup')

      assigns(:seat_incumbencies).each do |seat_incumbency|
        expect(seat_incumbency).to be_a(Grom::Node)
        expect(seat_incumbency.type).to eq('http://id.ukpds.org/schema/SeatIncumbency')
      end

      expect(assigns(:current_incumbency)).to be_a(Grom::Node)
      expect(assigns(:current_incumbency).type).to eq('http://id.ukpds.org/schema/SeatIncumbency')
      expect(assigns(:current_incumbency).current?).to be(true)
    end

    it 'assigns @seat_incumbencies in reverse chronological order' do
      expect(assigns(:seat_incumbencies)[0].start_date).to eq(DateTime.new(2010, 5, 6))
    end

    it 'assigns @current_incumbency to be the current incumbency' do
      expect(assigns(:current_incumbency).start_date).to eq(DateTime.new(2015, 5, 7))
    end

    it 'renders the members template' do
      expect(response).to render_template('index')
    end
  end

  describe 'GET current_member' do
    before(:each) do
      get :current_member, params: { constituency_id: 'vTNSMo38' }
    end

    it 'should have a response with a http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @constituency and @seat_incumbency' do
      expect(assigns(:constituency)).to be_a(Grom::Node)
      expect(assigns(:constituency).type).to eq('http://id.ukpds.org/schema/ConstituencyGroup')

      expect(assigns(:seat_incumbency)).to be_a(Grom::Node)
      expect(assigns(:seat_incumbency).type).to eq('http://id.ukpds.org/schema/SeatIncumbency')
    end

    it 'renders the current_member template' do
      expect(response).to render_template('current_member')
    end
  end
end
