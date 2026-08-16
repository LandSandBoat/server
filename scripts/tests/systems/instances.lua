describe('Instances', function()
    it('Waking the Colossus spawns Alexander', function()
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.ALZADAAL_UNDERSEA_RUINS })

        player:createInstance(7702)
        xi.test.world:tick(xi.tick.TIME)

        local instance = player:getInstance()
        assert(instance and instance:getID() == 7702)

        for _, mob in pairs(instance:getMobs()) do
            if mob:getName() == 'Alexander_WTC' then
                return
            end
        end

        assert(false, 'Alexander_WTC not spawned')
    end)

    it('respawns an instanced mob after its timer expires', function()
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.ALZADAAL_UNDERSEA_RUINS })

        player:createInstance(7702)
        xi.test.world:tick(xi.tick.TIME)

        local alexander
        for _, mob in pairs(player:getInstance():getMobs()) do
            if mob:getName() == 'Alexander_WTC' then
                alexander = player.entities:get(mob)
                break
            end
        end

        assert(alexander, 'Alexander_WTC not spawned')

        alexander:setRespawnTime(300)
        alexander:despawn()
        alexander.assert.no:isSpawned()

        xi.test.world:skipTime(305)
        xi.test.world:tick(xi.tick.SPAWN)

        alexander.assert:isSpawned()
    end)
end)
