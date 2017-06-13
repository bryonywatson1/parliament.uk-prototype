require 'rails_helper'

RSpec.describe 'parties', type: :routing do
  describe 'PartiesController' do
    include_examples 'index route', 'parties'

    # parties#current
    include_examples 'top level routes', 'parties', 'current'

    # parties#lookup
    include_examples 'top level routes', 'parties', 'lookup'

    # parties#a_to_z
    include_examples 'nested collection routes', 'parties', ['a-z'], 'a_to_z'

    # parties#letters
    include_examples 'collection a_to_z route with a letter', 'parties', ['a-z'], 'letters', 'a'

    context 'party' do
      # parties#show
      include_examples 'nested routes with an id', 'parties', 'jF43Jxoc', [], 'show'

      # parties/members#members
      # include_examples 'nested routes with an id', 'parties', 'jF43Jxoc', ['members'], 'members'
      it 'GET parties/members#members' do
        expect(get: '/parties/jF43Jxoc/members').to route_to(
          controller: 'parties/members',
          action:     'members',
          party_id:   'jF43Jxoc'
        )
      end

      # parties#a_to_z_members
      # include_examples 'nested routes with an id', 'parties', 'jF43Jxoc', ['members', 'a-z'], 'a_to_z_members'
      it 'GET parties/members#a_to_z_members' do
        expect(get: '/parties/jF43Jxoc/members/a-z').to route_to(
          controller: 'parties/members',
          action:     'a_to_z_members',
          party_id:   'jF43Jxoc'
        )
      end

      # parties/members#current_members
      # include_examples 'nested routes with an id', 'parties', 'jF43Jxoc', %w(members current), 'current_members'
      it 'GET parties/members#current_members' do
        expect(get: '/parties/jF43Jxoc/members/current').to route_to(
          controller: 'parties/members',
          action:     'current_members',
          party_id:   'jF43Jxoc'
        )
      end

      # parties/members#a_to_z_current_members
      # include_examples 'nested routes with an id', 'parties', 'jF43Jxoc', ['members', 'current', 'a-z'], 'a_to_z_current_members'
      it 'GET parties/members#current_members' do
        expect(get: '/parties/jF43Jxoc/members/current/a-z').to route_to(
          controller: 'parties/members',
          action:     'a_to_z_current_members',
          party_id:   'jF43Jxoc'
        )
      end

      # parties/members#members_letters
      # include_examples 'a_to_z route with an id and letter', 'parties', 'jF43Jxoc', ['members', 'a-z'], 'members_letters', 'a'
      it 'GET parties/members#members_letters' do
        expect(get: '/parties/jF43Jxoc/members/a-z/a').to route_to(
          controller: 'parties/members',
          action:     'members_letters',
          party_id:   'jF43Jxoc',
          letter:    'a',
        )
      end

      # parties/members#current_members_letters
      # include_examples 'a_to_z route with an id and letter', 'parties', 'jF43Jxoc', ['members', 'current', 'a-z'], 'current_members_letters', 'a'
      it 'GET parties/members#current_members_letters' do
        expect(get: '/parties/jF43Jxoc/members/current/a-z/a').to route_to(
          controller: 'parties/members',
          action:     'current_members_letters',
          party_id:   'jF43Jxoc',
          letter:    'a',
        )
      end
    end

    it 'GET parties#lookup_by_letters' do
      expect(get: '/parties/a').to route_to(
        controller: 'parties',
        action:     'lookup_by_letters',
        letters:    'a'
      )
    end
  end
end
