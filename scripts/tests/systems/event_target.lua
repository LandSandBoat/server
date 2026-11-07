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

    it('forgets a deleted dynamic mob that queued an event', function()
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE })
        local zone   = GetZone(xi.zone.WEST_RONFAURE)
        assert(zone, 'West Ronfaure not loaded')

        local mob = zone:insertDynamicEntity({
            objtype              = xi.objType.MOB,
            name                 = 'Queued_Event_Mob',
            x                    = player:getXPos(),
            y                    = player:getYPos(),
            z                    = player:getZPos(),
            rotation             = player:getRotPos(),
            groupId              = 5,
            groupZoneId          = xi.zone.GHELSBA_OUTPOST,
            minLevel             = 1,
            maxLevel             = 1,
            releaseIdOnDisappear = true,
            onMobDeath           = function(_, killer)
                killer:startEvent(9)
            end,
        })
        assert(mob, 'precondition: the mob was inserted')
        mob:setSpawn(player:getXPos(), player:getYPos(), player:getZPos(), player:getRotPos())
        mob:spawn()

        local mobID = mob:getID()
        player:startEvent(8)
        player:claimAndKillMob(mobID)
        DespawnMob(mobID)
        xi.test.world:skipTime(5)
        xi.test.world:tick()
        assert(GetMobByID(mobID) == nil, 'precondition: the mob was deleted')

        player.events:finish(8)
        assert(player:getEventTarget() == nil, 'the queued event kept the deleted mob')
    end)
end)
