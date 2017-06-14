class Parliaments::PartiesController < ApplicationController

  def index
    parliament_id = params[:parliament_id]

    @parliament, @parties = RequestHelper.filter_response_data(
      parliament_request.parliaments(parliament_id).parties,
      'http://id.ukpds.org/schema/ParliamentPeriod',
      'http://id.ukpds.org/schema/Party'
    )

    @parliament = @parliament.first
    @parties = @parties.multi_direction_sort({ member_count: :desc, name: :asc })
  end

  def show
    parliament_id = params[:parliament_id]
    party_id      = params[:party_id]

    @parliament, @party = RequestHelper.filter_response_data(
      parliament_request.parliaments(parliament_id).parties(party_id),
      'http://id.ukpds.org/schema/ParliamentPeriod',
      'http://id.ukpds.org/schema/Party'
    )

    fail ActionController::RoutingError, 'Not Found' if @party.empty?

    @parliament = @parliament.first
    @party      = @party.first
  end

end
