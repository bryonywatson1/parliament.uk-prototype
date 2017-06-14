class Parliaments::Houses::PartiesController < ApplicationController

    def house_parties
      parliament_id = params[:parliament_id]
      house_id      = params[:house_id]

      @parliament, @house, @parties, @letters = RequestHelper.filter_response_data(
        parliament_request.parliaments(parliament_id).houses(house_id).parties,
        'http://id.ukpds.org/schema/ParliamentPeriod',
        'http://id.ukpds.org/schema/House',
        'http://id.ukpds.org/schema/Party',
        ::Grom::Node::BLANK
      )

      @parliament = @parliament.first
      @house      = @house.first
      @parties    = @parties.sort_by(:name)
      @letters    = @letters.map(&:values)
    end

    def house_party
      parliament_id = params[:parliament_id]
      house_id      = params[:house_id]
      party_id      = params[:party_id]

      @parliament, @house, @party = RequestHelper.filter_response_data(
        parliament_request.parliaments(parliament_id).houses(house_id).parties(party_id),
        'http://id.ukpds.org/schema/ParliamentPeriod',
        'http://id.ukpds.org/schema/House',
        'http://id.ukpds.org/schema/Party'
      )

      fail ActionController::RoutingError, 'Not Found' if @party.empty?

      @parliament = @parliament.first
      @house      = @house.first
      @party      = @party.first
    end

end
