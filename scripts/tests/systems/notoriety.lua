-----------------------------------
-- A mob's enmity on a player shows up in the player's notoriety
-----------------------------------

describe('Notoriety', function()
    ---@type CClientEntityPair
    local player

    ---@type CTestEntity
    local mob

    ---@param holder CBaseEntity
    ---@param entity CBaseEntity
    local function inNotoriety(holder, entity)
        for _, entry in pairs(holder:getNotorietyList()) do
            if entry:getID() == entity:getID() then
                return true
            end
        end

        return false
    end

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

    it('lists a mob that turns on its charmer when charm wears off', function()
        mob:respawn()
        player:charm(mob, 5)
        assert(mob:isCharmed(), 'precondition: the rabbit is charmed')

        xi.test.world:skipTime(10)
        xi.test.world:tickEntity(mob)
        assert(not mob:isCharmed(), 'precondition: the charm wore off')
        assert(inNotoriety(player, mob), 'the rabbit is missing from the player\'s notoriety')
    end)

    -- The rabbit keeps an ownerless entry for the player, who comes back as a new object with the same id.
    describe('after the player zones out and back', function()
        before_each(function()
            mob:respawn()
            mob:addStatusEffect(xi.effect.PETRIFICATION, { power = 1, duration = 600, origin = mob })
            mob:addEnmity(player, 1, 1)
            player:gotoZone(xi.zone.LA_THEINE_PLATEAU)
            player:gotoZone(xi.zone.WEST_RONFAURE)
        end)

        it('rejoins notoriety as the player zones in', function()
            assert(inNotoriety(player, mob), 'the rabbit is missing from the player\'s notoriety')
        end)

        it('leaves notoriety when the mob dies after base enmity', function()
            mob:addBaseEnmity(player)
            assert(inNotoriety(player, mob), 'precondition: the rabbit is in the player\'s notoriety')

            mob:despawn()
            assert(not inNotoriety(player, mob), 'the dead rabbit is still in the player\'s notoriety')
        end)

        it('rejoins notoriety when the mob gains enmity', function()
            mob:addEnmity(player, 1, 1)
            assert(inNotoriety(player, mob), 'the rabbit is missing from the player\'s notoriety')
        end)
    end)

    describe('with a player-allegiance mob', function()
        ---@type CBaseEntity
        local ally

        -- Garrison allies are dynamic mobs on the player's side, so their enmity lands in the beastmen's notoriety.
        before_each(function()
            mob:respawn()
            mob:setUnkillable(false)

            local zone = GetZone(xi.zone.WEST_RONFAURE)
            assert(zone, 'West Ronfaure not loaded')

            local inserted = zone:insertDynamicEntity({
                objtype              = xi.objType.MOB,
                allegiance           = xi.allegiance.PLAYER,
                name                 = 'Notoriety_Ally',
                x                    = mob:getXPos(),
                y                    = mob:getYPos(),
                z                    = mob:getZPos(),
                rotation             = mob:getRotPos(),
                groupId              = 5,
                groupZoneId          = xi.zone.GHELSBA_OUTPOST,
                minLevel             = 1,
                maxLevel             = 1,
                releaseIdOnDisappear = true,
            })
            assert(inserted, 'precondition: the ally was inserted')
            ally = inserted
            ally:setSpawn(mob:getXPos(), mob:getYPos(), mob:getZPos(), mob:getRotPos())
            ally:spawn()

            ally:addEnmity(mob, 1, 1)
            assert(inNotoriety(mob, ally), 'precondition: the ally is in the rabbit\'s notoriety')

            -- The ally drops a dead target from its enmity list the next time it picks a target.
            mob:setHP(0)
            ally:updateTarget()
            mob:setHP(mob:getMaxHP())
        end)

        it('leaves notoriety when the ally drops its dead target', function()
            assert(not inNotoriety(mob, ally), 'the ally is still in the rabbit\'s notoriety')
            DespawnMob(ally:getID())
        end)

        -- Curing walks the target's notoriety, which held the freed ally.
        it('survives a cure on the target after the ally is deleted', function()
            local allyID = ally:getID()
            DespawnMob(allyID)
            xi.test.world:skipTime(5)
            xi.test.world:tick()
            assert(GetMobByID(allyID) == nil, 'precondition: the ally was deleted')

            player:updateEnmityFromCure(mob, 100)
        end)
    end)
end)
