require 'rails_helper'

RSpec.describe 'parliaments', type: :routing do
  describe 'ParliamentsController' do
    context 'parliaments' do
      # parliaments#index
      include_examples 'index route', 'parliaments'

      # parliaments#current
      include_examples 'top level routes', 'parliaments', 'current'

      # parliaments#lookup
      include_examples 'top level routes', 'parliaments', 'lookup'

      # parliaments#next
      include_examples 'top level routes', 'parliaments', 'next'

      # parliaments#previous
      include_examples 'top level routes', 'parliaments', 'previous'

      context 'parliament' do
        context 'show' do
          # parliaments#show
          include_examples 'nested routes with an id', 'parliaments', 'KL2k1BGP', [], 'show'
        end

        context 'next parliament' do
          # parliaments#next_parliament
          include_examples 'nested routes with an id', 'parliaments', 'KL2k1BGP', ['next'], 'next_parliament'
        end

        context 'previous parliament' do
          # parliaments#previous_parliament
          include_examples 'nested routes with an id', 'parliaments', 'KL2k1BGP', ['previous'], 'previous_parliament'
        end

        context 'members' do
          # parliaments/members#index
          it "GET parliaments/members#index" do
            expect(get: '/parliaments/KL2k1BGP/members').to route_to(
              controller:    'parliaments/members',
              action:        'index',
              parliament_id: 'KL2k1BGP',
            )
          end

          # parliaments/members#a_to_z_members
          it "GET parliaments/members#a_to_z_members" do
            expect(get: '/parliaments/KL2k1BGP/members/a-z').to route_to(
              controller:    'parliaments/members',
              action:        'a_to_z_members',
              parliament_id: 'KL2k1BGP',
            )
          end

          # parliaments#members_letters
          it "GET parliaments/members#members_letters" do
            expect(get: '/parliaments/KL2k1BGP/members/a-z/a').to route_to(
              controller:    'parliaments/members',
              action:        'members_letters',
              parliament_id: 'KL2k1BGP',
              letter:        'a'
            )
          end
        end

        context 'parties' do
          # parliaments/parties#index
          it "GET parliaments/parties#index" do
            expect(get: '/parliaments/KL2k1BGP/parties').to route_to(
              controller:    'parliaments/parties',
              action:        'index',
              parliament_id: 'KL2k1BGP'
            )
          end

          context 'party' do
            # parliaments/parties#show
            it "GET parliaments/parties#show" do
              expect(get: '/parliaments/KL2k1BGP/parties/12341234').to route_to(
                controller:    'parliaments/parties',
                action:        'show',
                parliament_id: 'KL2k1BGP',
                party_id:      '12341234'
              )
            end
          end

          context 'members' do
            # parliaments/parties/members#index
            it "GET parliaments/parties/members#index" do
              expect(get: '/parliaments/KL2k1BGP/parties/12341234/members').to route_to(
                controller:    'parliaments/parties/members',
                action:        'index',
                parliament_id: 'KL2k1BGP',
                party_id:      '12341234'
              )
            end

            # parliaments/parties/members#a_to_z_party_members
            it "GET parliaments/parties#a_to_z_party_members" do
              expect(get: '/parliaments/KL2k1BGP/parties/12341234/members/a-z').to route_to(
                controller:    'parliaments/parties/members',
                action:        'a_to_z_party_members',
                parliament_id: 'KL2k1BGP',
                party_id:      '12341234',
              )
            end

            # parliaments/parties/members#party_members_letters
            it "GET parliaments/parties#party_members_letters" do
              expect(get: '/parliaments/KL2k1BGP/parties/12341234/members/a-z/a').to route_to(
                controller:    'parliaments/parties/members',
                action:        'party_members_letters',
                parliament_id: 'KL2k1BGP',
                party_id:      '12341234',
                letter:        'a'
              )
            end
          end
        end

        context 'houses' do
          # parliaments/houses#index
          it 'GET parliaments/houses#index' do
            expect(get: '/parliaments/KL2k1BGP/houses').to route_to(
              controller:    'parliaments/houses',
              action:        'index',
              parliament_id: 'KL2k1BGP'
            )
          end

          context 'house' do
            # parliaments/houses#show
            it 'GET parliaments/houses#show' do
              expect(get: '/parliaments/KL2k1BGP/houses/12341234').to route_to(
                controller:    'parliaments/houses',
                action:        'show',
                parliament_id: 'KL2k1BGP',
                house_id:      '12341234'
              )
            end
          end

          context 'members' do
            # parliaments/houses/members#index
            it 'GET parliaments/houses/members#house_members' do
              expect(get: '/parliaments/KL2k1BGP/houses/12341234/members').to route_to(
                controller:    'parliaments/houses/members',
                action:        'index',
                parliament_id: 'KL2k1BGP',
                house_id:      '12341234'
              )
            end
            # parliaments/houses/members#a_to_z_house_members
            it 'GET parliaments/houses/members#a_to_z_house_members' do
              expect(get: '/parliaments/KL2k1BGP/houses/12341234/members/a-z').to route_to(
                controller:    'parliaments/houses/members',
                action:        'a_to_z_house_members',
                parliament_id: 'KL2k1BGP',
                house_id:      '12341234'
              )
            end

            #parliaments/houses/members#house_members_letters
            it 'GET parliaments/houses/members#house_members_letters' do
              expect(get: '/parliaments/KL2k1BGP/houses/12341234/members/a-z/a').to route_to(
                controller:    'parliaments/houses/members',
                action:        'house_members_letters',
                parliament_id: 'KL2k1BGP',
                house_id:      '12341234',
                letter:        'a'
              )
            end
          end

          context 'parties' do
            # parliaments/houses/parties#index
            it 'GET parliaments/houses/parties#index' do
              expect(get: '/parliaments/KL2k1BGP/houses/12341234/parties').to route_to(
                controller:    'parliaments/houses/parties',
                action:        'index',
                parliament_id: 'KL2k1BGP',
                house_id:      '12341234'
              )
            end

            context 'party' do
              # parliaments/houses/parties#show
              it 'GET parliaments/houses/parties#show' do
                expect(get: '/parliaments/12341234/houses/12345678/parties/87654321').to route_to(
                  controller:    'parliaments/houses/parties',
                  action:        'show',
                  parliament_id: '12341234',
                  house_id:      '12345678',
                  party_id:      '87654321'
                )
              end
            end

            context 'members' do
              # parliaments/houses/parties/members#house_party_members
              it 'GET parliaments/houses/parties/members#house_party_members' do
                expect(get: '/parliaments/12341234/houses/12345678/parties/87654321/members').to route_to(
                  controller:    'parliaments/houses/parties/members',
                  action:        'house_party_members',
                  parliament_id: '12341234',
                  house_id:      '12345678',
                  party_id:      '87654321'
                )
              end

              # parliaments/houses/parties/members#a_to_z_house_party_members
              it 'GET parliaments/houses/parties/members#a_to_z_house_party_members' do
                expect(get: '/parliaments/12341234/houses/12345678/parties/87654321/members/a-z').to route_to(
                  controller:    'parliaments/houses/parties/members',
                  action:        'a_to_z_house_party_members',
                  parliament_id: '12341234',
                  house_id:      '12345678',
                  party_id:      '87654321'
                )
              end

              #parliaments/houses/parties/members#house_party_members_letters
              it 'GET parliaments/houses/parties/members#house_party_members_letters' do
                expect(get: '/parliaments/12341234/houses/12345678/parties/87654321/members/a-z/a').to route_to(
                  controller:    'parliaments/houses/parties/members',
                  action:        'house_party_members_letters',
                  parliament_id: '12341234',
                  house_id:      '12345678',
                  party_id:      '87654321',
                  letter:        'a'
                )
              end
            end
          end
        end

        context 'constituencies' do
          # parliaments/constituencies#index
          #include_examples 'nested routes with an id', 'parliaments/constituencies', 'KL2k1BGP', ['constituencies'], 'constituencies'
          it 'GET parliaments/constituencies#index' do
            expect(get: '/parliaments/12345678/constituencies').to route_to(
              controller:    'parliaments/constituencies',
              action:        'index',
              parliament_id: '12345678'
            )
          end
          # parliaments/constituencies#a_to_z_constituencies
          it 'GET parliaments/constituencies#a_to_z_constituencies' do
            expect(get: '/parliaments/12345678/constituencies/a-z').to route_to(
              controller:    'parliaments/constituencies',
              action:        'a_to_z_constituencies',
              parliament_id: '12345678'
            )
          end

          # parliaments/constituencies#constituencies_letters
          #include_examples 'a_to_z route with an id and letter', 'parliaments/constituencies', 'KL2k1BGP', %w(constituencies a-z), 'constituencies_letters', 'a'
          it 'GET parliaments/constituencies#constituencies_letters' do
            expect(get: '/parliaments/12345678/constituencies/a-z/a').to route_to(
              controller:    'parliaments/constituencies',
              action:        'constituencies_letters',
              parliament_id: '12345678',
              letter:         'a'
            )
          end
        end
      end
    end
  end
end
