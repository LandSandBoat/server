describe('Gilfinder', function()
    local syrup
    ---@type CClientEntityPair
    local player

    setup(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.BOSTAUNIEUX_OUBLIETTE })
        syrup  = player.entities:get('Sewer_Syrup')
        syrup:setMobMod(xi.mobMod.GIL_MIN, 12000)
        syrup:setMobMod(xi.mobMod.GIL_MAX, 12000)
    end)

    before_each(function()
        -- Change player to THF99, set gil to 0 and respawn Sewer Syrup
        player:changeJob(xi.job.THF)
        player:setLevel(99)
        player:setGil(0)
        syrup:respawn()
        player.entities:moveTo(syrup)

        -- Sewer Syrup is supposed to drop exactly 12,000g but it's not updated yet
        syrup:setMobMod(xi.mobMod.GIL_MIN, 12000)
        syrup:setMobMod(xi.mobMod.GIL_MAX, 12000)
    end)

    it('drops GIL_MIN <> GIL_MAX without Gilfinder', function()
        player:changeJob(xi.job.WAR)
        player:claimAndKillMob(syrup)
        assert(player:getGil() == 12000, 'Expected to have 12000 gil exactly')
    end)

    it('base GF increases gil obtained by 50%', function()
        -- Gilfinder will have a minimum of 50% gil bonus, plus a number between 0 and your gilfinder level represented as x/256.
        player:claimAndKillMob(syrup)
        player.assert:hasGil(18000)
    end)

    -- TODO: Test GF+ items, test BLU GF trait etc
end)
