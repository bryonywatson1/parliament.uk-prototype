class Houses::PartiesController < ApplicationController

  def index
    house_id = params[:house_id]

    @house, @parties = RequestHelper.filter_response_data(
      parliament_request.houses(house_id).parties,
      'http://id.ukpds.org/schema/House',
      'http://id.ukpds.org/schema/Party'
    )

    @house = @house.first
    @parties = @parties.sort_by(:name)
  end

  def show
    house_id = params[:house_id]
    party_id = params[:party_id]

    @house, @party = RequestHelper.filter_response_data(
    parliament_request.houses(house_id).parties(party_id),
    'http://id.ukpds.org/schema/House',
    'http://id.ukpds.org/schema/Party'
    )

    @house = @house.first
    @party = @party.first
    @current_person_type, @other_person_type = HousesHelper.person_type_string(@house)

    raise ActionController::RoutingError, 'Invalid party id' if @party.nil?
  end

  def current_parties
    house_id = params[:house_id]

    @house, @parties = RequestHelper.filter_response_data(
      parliament_request.houses(house_id).parties.current,
      'http://id.ukpds.org/schema/House',
      'http://id.ukpds.org/schema/Party'
    )

    @house = @house.first
    @parties = @parties.multi_direction_sort({ member_count: :desc, name: :asc })
  end
end
