class People::HousesController < ApplicationController

  def houses
    person_id = params[:person_id]

    @person, @incumbencies = RequestHelper.filter_response_data(
      parliament_request.people(person_id).houses,
      'http://id.ukpds.org/schema/Person',
      'http://id.ukpds.org/schema/Incumbency'
    )

    @person = @person.first
    @incumbencies = @incumbencies.reverse_sort_by(:start_date)
  end

  def current_house
    person_id = params[:person_id]

    @person, @house = RequestHelper.filter_response_data(
      parliament_request.people(person_id).houses.current,
      'http://id.ukpds.org/schema/Person',
      'http://id.ukpds.org/schema/House'
    )

    @person = @person.first
    @house = @house.first
  end


end