-- Coverage for lua re-entering the AI state machine from inside a state.
--
-- Original bugs:
--   * (UAF -> crash) a stun from a mob's own TP move interrupted the CMobSkillState whose Update() was still running, freeing it mid-resolution.
--   * a state entered from within Cleanup() was popped straight back off, so the stun never applied and the finished state was cleaned up over and over.
--   * PAI->Reset() dropped the attack state without its Cleanup, leaving the mob engaged with nothing to swing: TP moves kept firing, auto-attacks did not.

describe('AI state re-entrancy', function()
    ---@type CClientEntityPair
    local player

    ---@type CTestEntity
    local mob

    before_each(function()
        player = xi.test.world:spawnPlayer({ level = 1, zone = xi.zone.BEAUCEDINE_GLACIER_S })
        mob    = player.entities:moveTo('Ruszor')
        mob:respawn()
        player:setUnkillable(true)
    end)

    after_each(function()
        for _, name in ipairs({ 'TEST_WS_EXIT', 'TEST_WS_USE', 'TEST_DISENGAGE' }) do
            mob:removeListener(name)
        end
    end)

    -- Ticks the mob a second at a time, collecting the states it passes through and whether it landed a hit (the player is healed back up so every swing shows).
    local function run(seconds)
        local seen = {}
        local hits = 0
        for _ = 1, seconds do
            local hp = player:getHP()
            xi.test.world:tickEntity(mob)
            xi.test.world:skipTime(1)
            if player:getHP() ~= hp then
                hits = hits + 1
            end

            player:setHP(player:getMaxHP())
            seen[mob:getCurrentAction()] = true
        end

        return seen, hits
    end

    local function engage()
        mob:addEnmity(player, 100, 100)
        run(3)
        assert(mob:getCurrentAction() == xi.action.category.BASIC_ATTACK, 'precondition: mob is engaged and attacking')
    end

    it('does not tear out a TP move that stuns its own user', function()
        engage()

        local exits = {}
        mob:addListener('WEAPONSKILL_STATE_EXIT', 'TEST_WS_EXIT', function(_, _, completed)
            table.insert(exits, completed)
        end)

        local resolved = false
        mob:addListener('WEAPONSKILL_USE', 'TEST_WS_USE', function(mobArg)
            resolved = true
            mobArg:stun(3000)
        end)

        mob:setTP(3000)
        mob:useMobAbility(xi.mobSkill.AQUA_BLAST, player, 2000)

        local seen = run(10)

        assert(resolved, 'the TP move should have resolved')
        assert(#exits == 1, 'the mob skill state should retire exactly once')
        assert(exits[1] == true, 'the skill resolved, so it must not report an interrupt')
        assert(seen[xi.action.category.SLEEP], 'the stun should have parked the mob inactive')
        assert(mob:getCurrentAction() == xi.action.category.BASIC_ATTACK, 'mob should be back to attacking')
    end)

    it('applies a stun asked for from a DISENGAGE listener', function()
        engage()

        local disengages = 0
        mob:addListener('DISENGAGE', 'TEST_DISENGAGE', function(mobArg)
            disengages = disengages + 1
            mobArg:stun(3000)
        end)

        mob:disengage()
        xi.test.world:tickEntity(mob)
        xi.test.world:skipTime(1)

        assert(disengages == 1, 'the disengage handler ran ' .. disengages .. ' times, expected once')
        assert(mob:getCurrentAction() == xi.action.category.SLEEP, 'the stun asked for during Cleanup should have applied')
    end)

    it('lets a mob re-engage after resetAI', function()
        engage()

        mob:resetAI()

        assert(not mob:isEngaged(), 'resetAI dropped the attack state, so the mob must not still look engaged')
        assert(mob:getCurrentAction() == xi.action.category.ROAMING, 'resetAI should leave the mob idle')

        mob:addEnmity(player, 100, 100)
        local _, hits = run(12)

        assert(mob:getCurrentAction() == xi.action.category.BASIC_ATTACK, 'mob should have re-engaged')
        assert(hits > 0, 'mob should be swinging again')
    end)
end)
