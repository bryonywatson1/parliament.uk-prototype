class Houses::MembersController < ApplicationController

  def index
    house_id = params[:house_id]

    @house, @people, @letters = RequestHelper.filter_response_data(
      parliament_request.houses(house_id).members,
      'http://id.ukpds.org/schema/House',
      'http://id.ukpds.org/schema/Person',
      ::Grom::Node::BLANK
    )

    @house = @house.first
    @people = @people.sort_by(:sort_name)
    @letters = @letters.map(&:value)

    @current_person_type, @other_person_type = HousesHelper.person_type_string(@house)
    @current_house_id, @other_house_id = HousesHelper.house_id_string(@house)
  end

  def current
    house_id = params[:house_id]

    @house, @people, @letters = RequestHelper.filter_response_data(
      parliament_request.houses(house_id).members.current,
      'http://id.ukpds.org/schema/House',
      'http://id.ukpds.org/schema/Person',
      ::Grom::Node::BLANK
    )

    @house = @house.first
    @people = @people.sort_by(:sort_name)
    @letters = @letters.map(&:value)

    @current_person_type, @other_person_type = HousesHelper.person_type_string(@house)
    @current_house_id, @other_house_id = HousesHelper.house_id_string(@house)
  end

  def letters
    house_id = params[:house_id]
    letter = params[:letter]

    @house, @people, @letters = RequestHelper.filter_response_data(
      parliament_request.houses(house_id).members(letter),
      'http://id.ukpds.org/schema/House',
      'http://id.ukpds.org/schema/Person',
      ::Grom::Node::BLANK
    )

    @house = @house.first
    @people = @people.sort_by(:sort_name)
    @letters = @letters.map(&:value)
    @current_person_type, @other_person_type = HousesHelper.person_type_string(@house)
    @current_house_id, @other_house_id = HousesHelper.house_id_string(@house)
  end

  def current_letters
    house_id = params[:house_id]
    letter = params[:letter]

    @house, @people, @letters = RequestHelper.filter_response_data(
      parliament_request.houses(house_id).members.current(letter),
      'http://id.ukpds.org/schema/House',
      'http://id.ukpds.org/schema/Person',
      ::Grom::Node::BLANK
    )

    @house = @house.first
    @people = @people.sort_by(:sort_name)
    @letters = @letters.map(&:value)
    @current_person_type, @other_person_type = HousesHelper.person_type_string(@house)
    @current_house_id, @other_house_id = HousesHelper.house_id_string(@house)
  end

  def a_to_z
    @house_id = params[:house_id]

    @letters = RequestHelper.process_available_letters(parliament_request.houses(@house_id).members.a_z_letters)
  end

  def a_to_z_current
    @house_id = params[:house_id]

    @letters = RequestHelper.process_available_letters(parliament_request.houses(@house_id).members.current.a_z_letters)
  end

end
