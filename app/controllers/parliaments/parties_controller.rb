class Parliaments::PartiesController < ApplicationController

  def parties
    parliament_id = params[:parliament_id]

    @parliament, @parties = RequestHelper.filter_response_data(
      parliament_request.parliaments(parliament_id).parties,
      'http://id.ukpds.org/schema/ParliamentPeriod',
      'http://id.ukpds.org/schema/Party'
    )

    @parliament = @parliament.first
    @parties = @parties.multi_direction_sort({ member_count: :desc, name: :asc })
  end

  def party
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

  def party_members
    parliament_id = params[:parliament_id]
    party_id      = params[:party_id]

    @parliament, @party, @people, @letters = RequestHelper.filter_response_data(
      parliament_request.parliaments(parliament_id).parties(party_id).members,
      'http://id.ukpds.org/schema/ParliamentPeriod',
      'http://id.ukpds.org/schema/Party',
      'http://id.ukpds.org/schema/Person',
      ::Grom::Node::BLANK
    )

    @parliament = @parliament.first
    @party      = @party.first
    @people     = @people.sort_by(:sort_name)
    @letters    = @letters.map(&:value)
  end

  def a_to_z_party_members
    parliament_id = params[:parliament_id]
    party_id      = params[:party_id]

    @parliament, @party, @letters = RequestHelper.filter_response_data(
      parliament_request.parliaments(parliament_id).parties(party_id).members,
      'http://id.ukpds.org/schema/ParliamentPeriod',
      'http://id.ukpds.org/schema/Party',
      ::Grom::Node::BLANK
    )

    @parliament = @parliament.first
    @party      = @party.first
    @letters    = @letters.map(&:value)
  end

  def party_members_letters
    parliament_id = params[:parliament_id]
    party_id      = params[:party_id]
    letter        = params[:letter]

    @parliament, @party, @people, @letters = RequestHelper.filter_response_data(
      parliament_request.parliaments(parliament_id).parties(party_id).members(letter),
      'http://id.ukpds.org/schema/ParliamentPeriod',
      'http://id.ukpds.org/schema/Party',
      'http://id.ukpds.org/schema/Person',
      ::Grom::Node::BLANK
    )

    @parliament = @parliament.first
    @party      = @party.first
    @people     = @people.sort_by(:sort_name)
    @letters    = @letters.map(&:value)
  end


end
