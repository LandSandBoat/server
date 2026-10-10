-----------------------------------
-- A mob's enmity on a player shows up in the player's notoriety
-----------------------------------

describe('Notoriety', function()
    ---@type CClientEntityPair
    local player

    ---@type CTestEntity
    local mob

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE })
        mob    = player.entities:moveTo('Wild_Rabbit')
    end)

    -- The next test reuses this character id, so the rabbit's enmity would follow it.
    after_each(function()
        mob:despawn()
    end)

    -- A petrified mob never targets the player, so only the notoriety list can see its enmity.
    it('reports enmity held by a mob that is not attacking', function()
        mob:respawn()
        mob:addStatusEffect(xi.effect.PETRIFICATION, { power = 1, duration = 600, origin = mob })
        mob:addEnmity(player, 1, 1)

        assert(player:hasEnmity(), 'the player has no enmity from the rabbit')
    end)
end)
