class People::MembersController < ApplicationController

  
  def members
    @people, @letters = RequestHelper.filter_response_data(
      parliament_request.people.members,
      'http://id.ukpds.org/schema/Person',
      ::Grom::Node::BLANK
    )

    @people = @people.sort_by(:sort_name)
    @letters = @letters.map(&:value)
  end

  def current_members
    @people, @letters = RequestHelper.filter_response_data(
      parliament_request.people.members.current,
      'http://id.ukpds.org/schema/Person',
      ::Grom::Node::BLANK
    )

    @people = @people.sort_by(:sort_name)
    @letters = @letters.map(&:value)
  end

  def members_letters
    letter = params[:letter]

    @people, @letters = RequestHelper.filter_response_data(
      parliament_request.people.members(letter),
      'http://id.ukpds.org/schema/Person',
      ::Grom::Node::BLANK
    )

    @people = @people.sort_by(:sort_name)
    @letters = @letters.map(&:value)
  end

  def current_members_letters
    letter = params[:letter]

    @people, @letters = RequestHelper.filter_response_data(
      parliament_request.people.members.current(letter),
      'http://id.ukpds.org/schema/Person',
      ::Grom::Node::BLANK
    )

    @people = @people.sort_by(:sort_name)
    @letters = @letters.map(&:value)
  end

  def a_to_z_members
    @letters = RequestHelper.process_available_letters(parliament_request.people.members.a_z_letters)
  end

  def a_to_z_current_members
    @letters = RequestHelper.process_available_letters(parliament_request.people.members.current.a_z_letters)
  end

end
