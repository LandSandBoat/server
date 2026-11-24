-----------------------------------
-- Titles: granting, lookup, and title changer purchases.
-----------------------------------
local packetReader = require('scripts.tests.helpers.packet_reader')

describe('Titles', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.PORT_BASTOK })
    end)

    describe('enum', function()
        it('keys titles by their retail names', function()
            assert(xi.title.NEW_ADVENTURER == 206)
            assert(xi.title.SEARINGSTAR == 382)
            assert(xi.title.GOLD_BALLISTAR == 378)
            assert(xi.title.CRYSTAL_CRUSHER == 1041)
            assert(xi.title.VENERATED_ADVENTURER == 1149)
        end)
    end)

    describe('grant', function()
        it('adds, sets, and deletes titles', function()
            player:addTitle(xi.title.CRYSTAL_CRUSHER)
            assert(player:hasTitle(xi.title.CRYSTAL_CRUSHER))
            assert(player:getTitle() == xi.title.CRYSTAL_CRUSHER)

            player:setTitle(xi.title.BUCKET_FISHER)
            assert(player:hasTitle(xi.title.BUCKET_FISHER))
            assert(player:getTitle() == xi.title.BUCKET_FISHER)

            player:delTitle(xi.title.BUCKET_FISHER)
            assert(not player:hasTitle(xi.title.BUCKET_FISHER))
            assert(player:getTitle() == xi.title.NONE)
            assert(player:hasTitle(xi.title.CRYSTAL_CRUSHER))
        end)

        it('stores the highest title id', function()
            player:addTitle(xi.title.VENERATED_ADVENTURER)
            assert(player:hasTitle(xi.title.VENERATED_ADVENTURER))
        end)
    end)

    describe('kill title', function()
        it('goes to every party member in the zone and nobody else', function()
            player:gotoZone(xi.zone.GHELSBA_OUTPOST)
            local member = xi.test.world:spawnPlayer({ zone = xi.zone.GHELSBA_OUTPOST })
            local outsider = xi.test.world:spawnPlayer({ zone = xi.zone.GHELSBA_OUTPOST })
            player.actions:inviteToParty(member)
            member.actions:acceptPartyInvite()

            local vatgit = player.entities:get('Warchief_Vatgit')
            vatgit:respawn()
            player.entities:moveTo(vatgit)
            player:claimAndKillMob(vatgit)

            assert(player:hasTitle(xi.title.WARCHIEF_WRECKER), 'Expected the killer to get the title')
            assert(player:getTitle() == xi.title.WARCHIEF_WRECKER, 'Expected the title to be set')
            assert(member:hasTitle(xi.title.WARCHIEF_WRECKER), 'Expected the party member to get the title')
            assert(not outsider:hasTitle(xi.title.WARCHIEF_WRECKER), 'Expected the outsider not to get the title')
        end)
    end)

    describe('title changer', function()
        before_each(function()
            player:setGil(1000)
        end)

        it('shows only the titles the player holds', function()
            player:addTitle(xi.title.BUCKET_FISHER)
            player.packets:clear()
            player.entities:gotoAndTrigger('Styi_Palneh', { eventId = 200, finishOption = 0 })

            local mask = packetReader.lastEventStart(player).params[0]
            assert(bit.band(mask, bit.lshift(1, 3)) == 0, 'Expected Bucket Fisher to be listed')
            assert(bit.band(mask, bit.lshift(1, 2)) ~= 0, 'Expected Bastok Welcoming Committee to be hidden')
        end)

        it('sets a held title for the page price', function()
            player:addTitle(xi.title.MOG_HOUSE_HANDYPERSON)
            player:setTitle(xi.title.NEW_ADVENTURER)

            player.entities:gotoAndTrigger('Styi_Palneh', { eventId = 200, finishOption = bit.bor(bit.lshift(5, 8), 1) })

            assert(player:getTitle() == xi.title.MOG_HOUSE_HANDYPERSON)
            assert(player:getGil() == 300, string.format('Expected 300 gil left, got %d', player:getGil()))
        end)

        it('refuses a title the player does not hold', function()
            player:setTitle(xi.title.NEW_ADVENTURER)

            player.entities:gotoAndTrigger('Styi_Palneh', { eventId = 200, finishOption = 3 })

            assert(player:getTitle() == xi.title.NEW_ADVENTURER)
            assert(not player:hasTitle(xi.title.BUCKET_FISHER))
            assert(player:getGil() == 1000)
        end)

        it('refuses a title the player cannot afford', function()
            player:addTitle(xi.title.MOG_HOUSE_HANDYPERSON)
            player:setTitle(xi.title.NEW_ADVENTURER)
            player:setGil(699)

            player.entities:gotoAndTrigger('Styi_Palneh', { eventId = 200, finishOption = bit.bor(bit.lshift(5, 8), 1) })

            assert(player:getTitle() == xi.title.NEW_ADVENTURER)
            assert(player:getGil() == 699)
        end)
    end)
end)
