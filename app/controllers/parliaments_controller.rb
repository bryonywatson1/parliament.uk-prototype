class ParliamentsController < ApplicationController
  def index
    @parliaments = parliament_request.parliaments.get.reverse_sort_by(:number)
  end

  def current
    @parliament = parliament_request.parliaments.current.get.filter('http://id.ukpds.org/schema/ParliamentPeriod').first

    redirect_to parliament_path(@parliament.graph_id)
  end

  def next
    @parliament = parliament_request.parliaments.next.get.filter('http://id.ukpds.org/schema/ParliamentPeriod').first

    redirect_to parliament_path(@parliament.graph_id)
  end

  def previous
    @parliament = parliament_request.parliaments.previous.get.filter('http://id.ukpds.org/schema/ParliamentPeriod').first

    redirect_to parliament_path(@parliament.graph_id)
  end

  def lookup
    source = params[:source]
    id = params[:id]

    @parliament = parliament_request.parliaments.lookup(source, id).get.first

    redirect_to parliament_path(@parliament.graph_id)
  end

  def show
    parliament_id = params[:parliament_id]

    @parliament, @parties = RequestHelper.filter_response_data(
      parliament_request.parliaments(parliament_id),
      'http://id.ukpds.org/schema/ParliamentPeriod',
      'http://id.ukpds.org/schema/Party'
    )

    @parliament = @parliament.first
    @parties    = @parties.sort_by(:name)
  end

  def next_parliament
    parliament_id = params[:parliament_id]

    @parliament = parliament_request.parliaments(parliament_id).next.get.filter('http://id.ukpds.org/schema/ParliamentPeriod').first

    redirect_to parliament_path(@parliament.graph_id)
  end

  def previous_parliament
    parliament_id = params[:parliament_id]

    @parliament = parliament_request.parliaments(parliament_id).previous.get.filter('http://id.ukpds.org/schema/ParliamentPeriod').first

    redirect_to parliament_path(@parliament.graph_id)
  end

  def constituencies
    parliament_id = params[:parliament_id]

    @parliament, @constituencies, @letters = RequestHelper.filter_response_data(
      parliament_request.parliaments(parliament_id).constituencies,
      'http://id.ukpds.org/schema/ParliamentPeriod',
      'http://id.ukpds.org/schema/ConstituencyGroup',
      ::Grom::Node::BLANK
    )

    @parliament     = @parliament.first
    @constituencies = @constituencies.sort_by(:name)
    @letters        = @letters.map(&:value)
  end

  def a_to_z_constituencies
    parliament_id = params[:parliament_id]

    @parliament, @constituencies, @letters = RequestHelper.filter_response_data(
      parliament_request.parliaments(parliament_id).constituencies,
      'http://id.ukpds.org/schema/ParliamentPeriod',
      'http://id.ukpds.org/schema/ConstituencyGroup',
      ::Grom::Node::BLANK
    )

    @parliament     = @parliament.first
    @constituencies = @constituencies.sort_by(:name)
    @letters        = @letters.map(&:value)
  end

  def constituencies_letters
    parliament_id = params[:parliament_id]
    letter        = params[:letter]

    @parliament, @constituencies, @letters = RequestHelper.filter_response_data(
      parliament_request.parliaments(parliament_id).constituencies(letter),
      'http://id.ukpds.org/schema/ParliamentPeriod',
      'http://id.ukpds.org/schema/ConstituencyGroup',
      ::Grom::Node::BLANK
    )

    @parliament     = @parliament.first
    @constituencies = @constituencies.sort_by(:name)
    @letters        = @letters.map(&:value)
  end
end
