require 'rails_helper'

RSpec.describe 'constituencies', type: :routing do
  describe 'ConstituenciesController' do
    include_examples 'index route', 'constituencies'

    # constituencies#lookup
    include_examples 'top level routes', 'constituencies', 'lookup'

    # constituencies#current
    include_examples 'top level routes', 'constituencies', 'current'

    # constituencies#postcode_lookup
    include_examples 'top level POST routes', 'constituencies', 'postcode_lookup'

    # constituencies#a_to_z
    include_examples 'nested collection routes', 'constituencies', ['a-z'], 'a_to_z'

    # constituencies#a_to_z_current
    include_examples 'nested collection routes', 'constituencies', ['current', 'a-z'], 'a_to_z_current'

    # constituencies#letters
    include_examples 'collection a_to_z route with a letter', 'constituencies', ['a-z'], 'letters', 'a'

    # constituencies#current_letters
    include_examples 'collection a_to_z route with a letter', 'constituencies', ['current', 'a-z'], 'current_letters', 'a'

    context 'constituency' do
      # constituencies#show
      include_examples 'nested routes with an id', 'constituencies', 'MtbjxRrE', [], 'show'

      # constituencies#contact_point
      it 'GET constituencies/contact_points#contact_point' do
        expect(get: '/constituencies/MtbjxRrE/contact-point').to route_to(
          controller:         'constituencies/contact_points',
          action:             'contact_point',
          constituency_id:    'MtbjxRrE'
        )
      end

      # constituencies#map
      include_examples 'nested routes with an id', 'constituencies', 'MtbjxRrE', ['map'], 'map'

      # constituencies/members#index
      it 'GET constituencies/members#index' do
        expect(get: '/constituencies/MtbjxRrE/members').to route_to(
          controller:         'constituencies/members',
          action:             'index',
          constituency_id:    'MtbjxRrE'
        )
      end

      # constituencies/members#current_member
      it 'GET constituencies/members#current_member' do
        expect(get: '/constituencies/MtbjxRrE/members/current').to route_to(
          controller:         'constituencies/members',
          action:             'current_member',
          constituency_id:    'MtbjxRrE'
        )
      end

    end

    it 'GET constituencies#lookup_by_letters' do
      expect(get: '/constituencies/a').to route_to(
        controller: 'constituencies',
        action:     'lookup_by_letters',
        letters:    'a'
      )
    end
  end
end
