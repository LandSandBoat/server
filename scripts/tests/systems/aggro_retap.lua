-----------------------------------
-- Aggro is re-evaluated as the player moves (spawn-list onUpdate)
-----------------------------------

describe('Aggro re-tap on movement', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.IFRITS_CAULDRON })
    end)

    it('aggros a player who approaches a mob already in view', function()
        local mob = player.entities:get('Volcanic_Bomb')
        mob:respawn()

        -- Aggro by sight (the "eyeline" case), at any level, within 20 yalms.
        mob:setAggressive(true)
        mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
        mob:setMobMod(xi.mobMod.DETECTION, xi.detects.SIGHT)
        mob:setMobMod(xi.mobMod.SIGHT_RANGE, 20)

        -- Roam past the post-spawn neutral window so the mob can aggro at all.
        for _ = 1, 10 do
            xi.test.world:skipTime(5)
            xi.test.world:tickEntity(mob)
        end

        local mx = mob:getXPos()
        local my = mob:getYPos()
        local mz = mob:getZPos()

        -- Face the mob down the +x approach lane, so the player is inside its
        -- sight line at both the far and near positions.
        mob:lookAt(mx + 100.0, my, mz)

        -- Step 1: enter render range, so the mob is shown to the client and added
        -- to the spawn list, but stay outside its 20-yalm sight range. It is now
        -- "in view" yet must not have aggroed.
        player.actions:move(mx + 30.0, my, mz)
        assert(not mob:isEngaged(), 'mob should not aggro from outside its sight range')

        -- Step 2: approach into sight range with clear line of sight. The mob is
        -- already in the spawn list, so aggro is only re-evaluated here via the
        -- onUpdate re-tap.
        player.actions:move(mx + 3.0, my, mz)
        assert(mob:isEngaged(), 'mob should aggro a player who approaches into its eyeline')
    end)
end)
