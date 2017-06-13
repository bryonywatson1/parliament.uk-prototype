class Parliaments::HousesController < ApplicationController

  def houses
    parliament_id = params[:parliament_id]

    @parliament, @houses = RequestHelper.filter_response_data(
      parliament_request.parliaments(parliament_id).houses,
      'http://id.ukpds.org/schema/ParliamentPeriod',
      'http://id.ukpds.org/schema/House'
    )

    @parliament = @parliament.first
    @houses     = @houses.sort_by(:name)
  end

  def house
    parliament_id = params[:parliament_id]
    house_id      = params[:house_id]

    @parliament, @house = RequestHelper.filter_response_data(
      parliament_request.parliaments(parliament_id).houses(house_id),
      'http://id.ukpds.org/schema/ParliamentPeriod',
      'http://id.ukpds.org/schema/House'
    )

    fail ActionController::RoutingError, 'Not Found' if @house.empty?

    @parliament = @parliament.first
    @house      = @house.first
  end

  def house_members
    parliament_id = params[:parliament_id]
    house_id      = params[:house_id]

    @parliament, @house, @people, @letters = RequestHelper.filter_response_data(
      parliament_request.parliaments(parliament_id).houses(house_id).members,
      'http://id.ukpds.org/schema/ParliamentPeriod',
      'http://id.ukpds.org/schema/House',
      'http://id.ukpds.org/schema/Person',
      ::Grom::Node::BLANK
    )

    @parliament = @parliament.first
    @house      = @house.first
    @people     = @people.sort_by(:sort_name)
    @letters    = @letters.map(&:value)
  end

  def a_to_z_house_members
    parliament_id = params[:parliament_id]
    house_id      = params[:house_id]

    @parliament, @house, @letters = RequestHelper.filter_response_data(
      parliament_request.parliaments(parliament_id).houses(house_id).members,
      'http://id.ukpds.org/schema/ParliamentPeriod',
      'http://id.ukpds.org/schema/House',
      ::Grom::Node::BLANK
    )

    @parliament = @parliament.first
    @house      = @house.first
    @letters    = @letters.map(&:value)
  end

  def house_members_letters
    parliament_id = params[:parliament_id]
    house_id      = params[:house_id]
    letter        = params[:letter]

    @parliament, @house, @people, @letters = RequestHelper.filter_response_data(
      parliament_request.parliaments(parliament_id).houses(house_id).members(letter),
      'http://id.ukpds.org/schema/ParliamentPeriod',
      'http://id.ukpds.org/schema/House',
      'http://id.ukpds.org/schema/Person',
      ::Grom::Node::BLANK
    )

    @parliament = @parliament.first
    @house      = @house.first
    @people     = @people.sort_by(:sort_name)
    @letters    = @letters.map(&:value)
  end

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

  def house_party_members
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
