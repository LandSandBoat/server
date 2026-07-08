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
end)
