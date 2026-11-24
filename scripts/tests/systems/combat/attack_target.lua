-- The attack state keeps its own copy of the target next to the entity's battle target, and only re-syncs it when the copy is set and compares unequal.
--
-- Original bug: (null deref -> crash) the swing resolved that stale copy instead of the battle target the attack state had just checked.

describe('Auto-attack target', function()
    ---@param seconds integer
    local function run(seconds)
        for _ = 1, seconds do
            xi.test.world:skipTime(1)
            xi.test.world:tick()
        end
    end

    describe('of a charmed player', function()
        ---@type CClientEntityPair
        local victim

        ---@type CClientEntityPair
        local other

        ---@type CTestEntity
        local mob

        before_each(function()
            victim = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE, job = xi.job.WAR, level = 75 })
            other  = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE, job = xi.job.WAR, level = 75 })
            mob    = victim.entities:moveTo('Wild_Rabbit')
            mob:respawn()
            other:setPos(mob:getXPos(), mob:getYPos(), mob:getZPos())
            victim:setUnkillable(true)
            other:setUnkillable(true)
        end)

        after_each(function()
            mob:despawn()
        end)

        -- the charm controller refuses to drop a target the victim cannot validate, so only the attack state's copy is cleared
        it('swings at the charmer\'s target', function()
            mob:addEnmity(other, 1, 1000)
            run(1)
            assert(mob:isEngaged(), 'precondition: the rabbit is fighting the other player')

            mob:charm(victim)
            run(7)
            assert(victim:isEngaged(), 'precondition: the charmed player engaged the rabbit\'s target')

            victim:setBattleID(1)

            local hits = 0
            for _ = 1, 15 do
                local hp = other:getHP()
                run(1)
                if other:getHP() < hp then
                    hits = hits + 1
                end

                other:setHP(other:getMaxHP())
            end

            assert(victim:isEngaged(), 'the charmed player should be engaged on the rabbit\'s target')
            assert(hits > 0, 'the charmed player never swung')
        end)
    end)

    describe('of a mob whose target zones back in', function()
        ---@type CClientEntityPair
        local filler

        ---@type CClientEntityPair
        local target

        ---@type CTestEntity
        local mob

        before_each(function()
            filler = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE })
            target = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE, level = 1 })
            mob    = target.entities:moveTo('Wild_Rabbit')
            mob:respawn()
            target:setUnkillable(true)
        end)

        after_each(function()
            mob:despawn()
        end)

        -- the player comes back as a new object with the same id in a different slot, so the old copy compares equal but no longer resolves
        it('swings at the player in their new slot', function()
            mob:addEnmity(target, 1, 1000)
            run(4)
            assert(mob:isEngaged(), 'precondition: the rabbit is fighting the player')

            local oldTargId = target:getTargID()
            filler:gotoZone(xi.zone.LA_THEINE_PLATEAU)
            target:gotoZone(xi.zone.LA_THEINE_PLATEAU)
            target:gotoZone(xi.zone.WEST_RONFAURE)
            assert(target:getTargID() ~= oldTargId, 'precondition: the player zoned back into a different slot')
            target:setPos(mob:getXPos(), mob:getYPos(), mob:getZPos())

            local hits = 0
            for _ = 1, 10 do
                local hp = target:getHP()
                run(1)
                if target:getHP() < hp then
                    hits = hits + 1
                end

                target:setHP(target:getMaxHP())
            end

            assert(mob:isEngaged(), 'the rabbit should still be fighting the player')
            assert(hits > 0, 'the rabbit never swung')
        end)
    end)
end)
