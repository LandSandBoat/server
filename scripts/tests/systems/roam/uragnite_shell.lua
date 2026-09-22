describe('Uragnite shell', function()
    ---@type CClientEntityPair
    local player

    ---@type CTestEntity
    local mob
    local baselineMods

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.CEIZAK_BATTLEGROUNDS })
        mob    = player.entities:get('Bight_Uragnite')
        assert(mob, 'Bight Uragnite is not loaded')
        mob:clearTimerQueue()
        mob:respawn()
        mob:clearPath()

        baselineMods = {}
        for _, modifier in ipairs({ xi.mod.UDMGPHYS, xi.mod.UDMGRANGE, xi.mod.UDMGMAGIC, xi.mod.UDMGBREATH, xi.mod.REGEN }) do
            baselineMods[modifier] = mob:getMod(modifier)
        end
    end)

    after_each(function()
        if mob then
            mob:clearTimerQueue()
            mob:respawn()
        end
    end)

    it('spawns open', function()
        assert(mob:getAnimationSub() == 4, 'expected animationSub 4, got ' .. mob:getAnimationSub())
    end)

    it('closes during a rest and reopens', function()
        local closedAt = nil
        local openedAt = nil
        for second = 1, 300 do
            xi.test.world:skipTime(1)
            xi.test.world:tickEntity(mob)
            local sub = mob:getAnimationSub()
            if sub == 5 and not closedAt then
                closedAt = second
            elseif sub == 4 and closedAt and not openedAt then
                openedAt = second
                break
            end
        end

        assert(closedAt, 'the shell never closed')
        assert(openedAt, 'the shell never opened again')
        local closed = openedAt - closedAt
        assert(closed >= 15 and closed <= 35, 'shell was closed for ' .. closed .. ' s')
    end)

    it('restores attacks and modifiers after respawning from a closed shell', function()
        xi.mix.uragnite.config(mob, { chanceToShell = 100, timeInShellMin = 45, timeInShellMax = 45 })
        mob:takeDamage(1, player, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
        assert(mob:getAnimationSub() == 5, 'physical damage did not close the shell')

        -- The respawn helper advances the mob's clock by 20 seconds.
        mob:respawn()
        assert(mob:getAnimationSub() == 4, 'the respawned shell stayed closed')
        for modifier, baseline in pairs(baselineMods) do
            assert(mob:getMod(modifier) == baseline, 'respawn did not restore modifier ' .. modifier)
        end

        -- Reset the mob's clock before combat.
        xi.test.world:tickEntity(mob)
        local mobId = mob:getID()
        player:setUnkillable(true)
        player.entities:moveTo(mobId)
        player.packets:clear()
        mob:addEnmity(player, 100, 100)

        for _ = 1, 15 do
            xi.test.world:tickEntity(mob)
            xi.test.world:skipTime(1)
        end

        local attacks = 0
        for _, packet in ipairs(player.packets:actionPackets()) do
            if
                packet.m_uID == mobId and
                packet.cmd_no == xi.action.category.BASIC_ATTACK
            then
                attacks = attacks + 1
            end
        end

        assert(attacks > 0, 'the respawned Uragnite cannot auto-attack')
    end)

    it('does not let a skipped idle closure reopen a combat shell', function()
        stub('math.randomInt', function(minimum)
            return minimum
        end)

        xi.mix.uragnite.config(mob, { chanceToShell = 100, timeInShellMin = 45, timeInShellMax = 45 })
        mob:triggerListener('ROAM_TICK', mob)
        xi.test.world:skipTime(10)
        player:setUnkillable(true)
        player.entities:moveTo(mob:getID())
        mob:addEnmity(player, 100, 100)
        xi.test.world:tickEntity(mob)
        assert(mob:isEngaged(), 'Uragnite did not engage')
        mob:takeDamage(1, player, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
        assert(mob:getAnimationSub() == 5)

        -- Idle shell opens at 43 seconds. Combat shell opens at 55.
        xi.test.world:skipTime(16)
        xi.test.world:tickEntity(mob)
        xi.test.world:skipTime(18)
        xi.test.world:tickEntity(mob)
        assert(mob:getAnimationSub() == 5, 'the skipped idle closure reopened the combat shell')
        for modifier, baseline in pairs(baselineMods) do
            assert(mob:getMod(modifier) == baseline + (modifier == xi.mod.REGEN and 50 or -7500), 'shell modifier changed early: ' .. modifier)
        end

        xi.test.world:skipTime(12)
        xi.test.world:tickEntity(mob)
        assert(mob:getAnimationSub() == 4)
        for modifier, baseline in pairs(baselineMods) do
            assert(mob:getMod(modifier) == baseline, 'shell modifier was removed twice: ' .. modifier)
        end
    end)

    it('removes the regen applied by each shell after its configuration changes', function()
        stub('math.randomInt', function(minimum)
            return minimum
        end)

        mob:triggerListener('ROAM_TICK', mob)
        xi.test.world:skipTime(26)
        xi.test.world:tickEntity(mob)
        assert(mob:getAnimationSub() == 5)
        assert(mob:getMod(xi.mod.REGEN) == baselineMods[xi.mod.REGEN] + 50)

        xi.mix.uragnite.config(mob, { inShellRegen = 100, chanceToShell = 100, timeInShellMin = 30, timeInShellMax = 30 })
        player:setUnkillable(true)
        player.entities:moveTo(mob:getID())
        mob:addEnmity(player, 100, 100)
        xi.test.world:tickEntity(mob)
        xi.test.world:skipTime(18)
        xi.test.world:tickEntity(mob)
        assert(mob:getAnimationSub() == 4)
        for modifier, baseline in pairs(baselineMods) do
            assert(mob:getMod(modifier) == baseline, 'the first shell removed the wrong modifier amount: ' .. modifier)
        end

        mob:takeDamage(1, player, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
        assert(mob:getAnimationSub() == 5)
        assert(mob:getMod(xi.mod.REGEN) == baselineMods[xi.mod.REGEN] + 100)
        xi.test.world:skipTime(31)
        xi.test.world:tickEntity(mob)
        assert(mob:getAnimationSub() == 4)
        for modifier, baseline in pairs(baselineMods) do
            assert(mob:getMod(modifier) == baseline, 'the next shell did not restore its baseline: ' .. modifier)
        end
    end)

    it('keeps the original opening deadline when the idle close is processed late', function()
        stub('math.randomInt', function(minimum)
            return minimum
        end)

        mob:triggerListener('ROAM_TICK', mob)
        xi.test.world:skipTime(40)
        xi.test.world:tickEntity(mob)
        assert(mob:getAnimationSub() == 5)
        xi.test.world:skipTime(4)
        xi.test.world:tickEntity(mob)
        assert(mob:getAnimationSub() == 4, 'the late closure postponed the original opening deadline')
        for modifier, baseline in pairs(baselineMods) do
            assert(mob:getMod(modifier) == baseline, 'the late shell left a modifier applied: ' .. modifier)
        end
    end)
end)
