describe('Death during a pending Warp effect', function()
    ---@type CClientEntityPair
    local player

    local function settle()
        for _ = 1, 8 do
            xi.test.world:skipTime(1)
        end
    end

    before_each(function()
        -- Home point in Port San d'Oria but die in West Ronfaure
        player = xi.test.world:spawnPlayer({ zone = xi.zone.PORT_SAN_DORIA, job = xi.job.WHM, level = 30 })
        player:setHomePoint()

        player:setPos(0, 0, 0, 0, xi.zone.WEST_RONFAURE)
        settle()
    end)

    it('a normal death leaves the player dead where they fell', function()
        player:setHP(0)
        xi.test.world:tickEntity(player)
        settle()

        assert(player:isDead(), 'player should still be dead')
        assert(player:getZoneID() == xi.zone.WEST_RONFAURE, 'death must not warp the player')
    end)

    it('warps a corpse home but leaves it dead', function()
        player:addStatusEffect(xi.effect.TELEPORT, { power = xi.teleport.id.WARP, duration = 60, origin = player })
        assert(player:hasStatusEffect(xi.effect.TELEPORT), 'precondition: Warp effect is active')

        player:setHP(0)
        xi.test.world:tickEntity(player) -- death strips the death-flagged Warp effect
        assert(not player:hasStatusEffect(xi.effect.TELEPORT), 'death should have removed the Warp effect')

        settle()

        assert(player:getZoneID() == xi.zone.PORT_SAN_DORIA, 'the Warp should carry the player to their home point')
        assert(player:isDead(), 'player must arrive dead, not revived')
    end)
end)
