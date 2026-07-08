describe('Zone Mesh', function()
    it('AlTaieu below bridge is shallow water', function()
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.ALTAIEU })
        player:setPos(-1, 0.0, -500.64)
        local zone = player:getZone()
        assert(zone)
        assert(zone:getTerrainType(player:getPos()) == xi.terrain.SHALLOW_WATER)
    end)

    it('AlTaieu on bridge is stone', function()
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.ALTAIEU })
        player:setPos(-0.3524, -6.4856, -503.6324)
        local zone = player:getZone()
        assert(zone)
        assert(zone:getTerrainType(player:getPos()) == xi.terrain.STONE)
    end)

    it('Eldieme Necropolis lower floor is 16', function()
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.THE_ELDIEME_NECROPOLIS })
        player:setPos(69.84, 0, 18.15)
        local zone = player:getZone()
        assert(zone)
        assert(zone:getFloorId(player:getPos()) == 16)
    end)

    it('Eldieme Necropolis upper floor is 15', function()
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.THE_ELDIEME_NECROPOLIS })
        player:setPos(54.84, -27.5, 16)
        local zone = player:getZone()
        assert(zone)
        assert(zone:getFloorId(player:getPos()) == 15)
    end)

    it('East Ronfaure river positions are water terrain', function()
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.EAST_RONFAURE })
        local zone = player:getZone()
        assert(zone)

        local riverPositions =
        {
            { 380.4925, -26.5,  -39.9 },
            { 379.3,    -26.5,  -53.6 },
            { 379.1167, -26.5,  -77.35 },
            { 382.1155, -16.50, -114.30 },
        }

        for _, pos in ipairs(riverPositions) do
            player:setPos(pos[1], pos[2], pos[3])
            local terrain = zone:getTerrainType(player:getPos())
            assert(terrain == xi.terrain.SHALLOW_WATER or terrain == xi.terrain.DEEP_WATER,
                string.format('Expected water terrain at (%.4f, %.2f, %.2f), got %d', pos[1], pos[2], pos[3], terrain))
        end
    end)
end)
