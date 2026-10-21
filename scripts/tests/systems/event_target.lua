-----------------------------------
-- An interaction that starts no event must not become the actor of the player's next one.
-----------------------------------
local packetReader = require('scripts.tests.helpers.packet_reader')

describe('Event target', function()
    it('is not inherited from a trade that started no event', function()
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.AL_ZAHBI })
        player:addItem(xi.item.FIRE_CRYSTAL)
        player.actions:tradeNpc('Bornahn', { xi.item.FIRE_CRYSTAL })
        player.packets:clear()

        player:startEvent(8)

        assert(packetReader.lastEventStart(player).actor == player:getID(), 'The traded NPC became the actor')
        player.events:expect({ eventId = 8 })
    end)

    it('is not inherited from a mob engaging the player', function()
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.BOSTAUNIEUX_OUBLIETTE })
        local syrup  = player.entities:get('Sewer_Syrup')
        syrup:respawn()
        player.entities:moveTo(syrup)
        syrup:updateEnmity(player)
        assert(syrup:isEngaged(), 'Sewer Syrup did not engage the player')
        player.packets:clear()

        player:startEvent(8)

        assert(packetReader.lastEventStart(player).actor == player:getID(), 'The engaging mob became the actor')
        player.events:expect({ eventId = 8 })
    end)

    it('is not inherited from a kill that started no event', function()
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.BOSTAUNIEUX_OUBLIETTE })
        local syrup  = player.entities:get('Sewer_Syrup')
        syrup:respawn()
        player.entities:moveTo(syrup)
        player:claimAndKillMob(syrup)
        player.packets:clear()

        player:startEvent(8)

        assert(packetReader.lastEventStart(player).actor == player:getID(), 'The killed mob became the actor')
        player.events:expect({ eventId = 8 })
    end)
end)
