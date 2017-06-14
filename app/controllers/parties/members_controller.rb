class Parties::MembersController < ApplicationController
  def index
    party_id = params[:party_id]

    @party, @people, @letters = RequestHelper.filter_response_data(
      parliament_request.parties(party_id).members,
      'http://id.ukpds.org/schema/Party',
      'http://id.ukpds.org/schema/Person',
      ::Grom::Node::BLANK
    )

    @party = @party.first
    @people = @people.sort_by(:sort_name)
    @letters = @letters.map(&:value)
  end

  def current_members
    party_id = params[:party_id]

    @party, @people, @letters = RequestHelper.filter_response_data(
      parliament_request.parties(party_id).members.current,
      'http://id.ukpds.org/schema/Party',
      'http://id.ukpds.org/schema/Person',
      ::Grom::Node::BLANK
    )

    @party = @party.first
    @people = @people.sort_by(:sort_name)
    @letters = @letters.map(&:value)
  end

  def members_letters
    letter = params[:letter]
    party_id = params[:party_id]

    @party, @people, @letters = RequestHelper.filter_response_data(
      parliament_request.parties(party_id).members(letter),
      'http://id.ukpds.org/schema/Party',
      'http://id.ukpds.org/schema/Person',
      ::Grom::Node::BLANK
    )

    @party = @party.first
    @people = @people.sort_by(:sort_name)
    @letters = @letters.map(&:value)
  end

  def current_members_letters
    letter = params[:letter]
    party_id = params[:party_id]

    @party, @people, @letters = RequestHelper.filter_response_data(
      parliament_request.parties(party_id).members.current(letter),
      'http://id.ukpds.org/schema/Party',
      'http://id.ukpds.org/schema/Person',
      ::Grom::Node::BLANK
    )

    @party = @party.first
    @people = @people.sort_by(:sort_name)
    @letters = @letters.map(&:value)
  end

  def a_to_z_members
    @party_id = params[:party_id]

    @letters = RequestHelper.process_available_letters(parliament_request.parties(@party_id).members.a_z_letters)
  end

  def a_to_z_current_members
    @party_id = params[:party_id]

    @letters = RequestHelper.process_available_letters(parliament_request.parties(@party_id).members.current.a_z_letters)
  end


end
