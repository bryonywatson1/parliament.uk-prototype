class Parliaments::Houses::Parties::MembersController < ApplicationController

  def index
    parliament_id = params[:parliament_id]
    house_id      = params[:house_id]
    party_id      = params[:party_id]

    @parliament, @house, @party, @people, @letters = RequestHelper.filter_response_data(
    parliament_request.parliaments(parliament_id).houses(house_id).parties(party_id).members,
    'http://id.ukpds.org/schema/ParliamentPeriod',
    'http://id.ukpds.org/schema/House',
    'http://id.ukpds.org/schema/Party',
    'http://id.ukpds.org/schema/Person',
    ::Grom::Node::BLANK
    )

    @parliament = @parliament.first
    @house      = @house.first
    @party      = @party.first
    @people     = @people.sort_by(:sort_name)
    @letters    = @letters.map(&:value)
  end


  def a_to_z_house_party_members
    parliament_id = params[:parliament_id]
    house_id      = params[:house_id]
    party_id      = params[:party_id]

    @parliament, @house, @party, @letters = RequestHelper.filter_response_data(
    parliament_request.parliaments(parliament_id).houses(house_id).parties(party_id).members,
    'http://id.ukpds.org/schema/ParliamentPeriod',
    'http://id.ukpds.org/schema/House',
    'http://id.ukpds.org/schema/Party',
    ::Grom::Node::BLANK
    )

    @parliament = @parliament.first
    @house      = @house.first
    @party      = @party.first
    @letters    = @letters.map(&:value)
  end

  def house_party_members_letters
    parliament_id = params[:parliament_id]
    house_id      = params[:house_id]
    party_id      = params[:party_id]
    letter        = params[:letter]

    @parliament, @house, @party, @people, @letters = RequestHelper.filter_response_data(
    parliament_request.parliaments(parliament_id).houses(house_id).parties(party_id).members(letter),
    'http://id.ukpds.org/schema/ParliamentPeriod',
    'http://id.ukpds.org/schema/House',
    'http://id.ukpds.org/schema/Party',
    'http://id.ukpds.org/schema/Person',
    ::Grom::Node::BLANK
    )

    @parliament = @parliament.first
    @house      = @house.first
    @party      = @party.first
    @people     = @people.sort_by(:sort_name)
    @letters    = @letters.map(&:value)
  end
end
