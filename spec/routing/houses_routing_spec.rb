require 'rails_helper'

RSpec.describe 'houses', type: :routing do
  describe 'HousesController' do
    include_examples 'index route', 'houses'

    # houses#lookup
    include_examples 'top level routes', 'houses', 'lookup'

    context 'house' do
      # houses#show
      include_examples 'nested routes with an id', 'houses', 'KL2k1BGP', [], 'show'

      context 'members' do
        # houses/members#members
        it 'GET houses/members#members' do
          expect(get: '/houses/KL2k1BGP/members').to route_to(
            controller: 'houses/members',
            action:     'members',
            house_id:   'KL2k1BGP',
          )
        end

        # houses/members#a_to_z_members
        it 'GET houses/members#a_to_z_members' do
          expect(get: '/houses/KL2k1BGP/members/a-z').to route_to(
            controller: 'houses/members',
            action:     'a_to_z_members',
            house_id:   'KL2k1BGP',
          )
        end

        # houses/members#current_members
        it 'GET houses/members#current_members' do
          expect(get: '/houses/KL2k1BGP/members/current').to route_to(
            controller: 'houses/members',
            action:     'current_members',
            house_id:   'KL2k1BGP',
          )
        end

        # houses/members#a_to_z_current_members
        it 'GET houses/members#a_to_z_current_members' do
          expect(get: '/houses/KL2k1BGP/members/current/a-z').to route_to(
            controller: 'houses/members',
            action:     'a_to_z_current_members',
            house_id:   'KL2k1BGP',
          )
        end

        # houses/members#members_letters
        it 'GET houses/members#members_letters' do
          expect(get: '/houses/KL2k1BGP/members/a-z/a').to route_to(
            controller: 'houses/members',
            action:     'members_letters',
            house_id:   'KL2k1BGP',
            letter:     'a'
          )
        end

        # houses/members#current_members_letters
        it 'GET houses/members#current_members_letters' do
          expect(get: '/houses/KL2k1BGP/members/current/a-z/a').to route_to(
            controller: 'houses/members',
            action:     'current_members_letters',
            house_id:   'KL2k1BGP',
            letter:     'a'
          )
        end
      end

      context 'parties' do
        # houses/parties#parties
        it 'GET houses/parties#parties' do
          expect(get: '/houses/KL2k1BGP/parties').to route_to(
            controller: 'houses/parties',
            action:     'parties',
            house_id:   'KL2k1BGP',
          )
        end

        # houses#current_parties
        it 'GET houses/parties#current_parties' do
          expect(get: '/houses/KL2k1BGP/parties/current').to route_to(
            controller: 'houses/parties',
            action:     'current_parties',
            house_id:   'KL2k1BGP',
          )
        end

        it 'GET houses#party' do
          expect(get: '/houses/KL2k1BGP/parties/jF43Jxoc').to route_to(
            controller: 'houses/parties',
            action:     'party',
            house_id:   'KL2k1BGP',
            party_id:   'jF43Jxoc'
          )
        end

        it 'GET houses#party_members' do
          expect(get: '/houses/KL2k1BGP/parties/jF43Jxoc/members').to route_to(
            controller: 'houses/parties',
            action:     'party_members',
            house_id:   'KL2k1BGP',
            party_id:   'jF43Jxoc'
          )
        end

        it 'GET houses#a_to_z_party_members' do
          expect(get: '/houses/KL2k1BGP/parties/jF43Jxoc/members/a-z').to route_to(
            controller: 'houses/parties',
            action:     'a_to_z_party_members',
            house_id:   'KL2k1BGP',
            party_id:   'jF43Jxoc'
          )
        end

        it 'GET houses#party_members_letters' do
          expect(get: '/houses/KL2k1BGP/parties/jF43Jxoc/members/a-z/a').to route_to(
            controller: 'houses/parties',
            action:     'party_members_letters',
            house_id:   'KL2k1BGP',
            party_id:   'jF43Jxoc',
            letter:     'a'
          )
        end

        it 'GET houses#current_party_members' do
          expect(get: '/houses/KL2k1BGP/parties/jF43Jxoc/members/current').to route_to(
            controller: 'houses/parties',
            action:     'current_party_members',
            house_id:   'KL2k1BGP',
            party_id:   'jF43Jxoc'
          )
        end

        it 'GET houses#a_to_z_current_party_members' do
          expect(get: '/houses/KL2k1BGP/parties/jF43Jxoc/members/current/a-z').to route_to(
            controller: 'houses/parties',
            action:     'a_to_z_current_party_members',
            house_id:   'KL2k1BGP',
            party_id:   'jF43Jxoc'
          )
        end

        it 'GET houses#a_to_z_current_party_members' do
          expect(get: '/houses/KL2k1BGP/parties/jF43Jxoc/members/current/a-z/a').to route_to(
            controller: 'houses/parties',
            action:     'current_party_members_letters',
            house_id:   'KL2k1BGP',
            party_id:   'jF43Jxoc',
            letter:     'a'
          )
        end

        it 'GET houses#lookup_by_letters' do
          expect(get: '/houses/a').to route_to(
            controller: 'houses',
            action:     'lookup_by_letters',
            letters:    'a'
          )
        end
      end
    end
  end
end
