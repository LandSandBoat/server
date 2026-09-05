describe('Actions during events', function()
    ---@type CClientEntityPair
    local player
    ---@type CTestEntity
    local mob

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.BEAUCEDINE_GLACIER_S, job = xi.job.BLM, level = 75 })
        mob    = player.entities:moveTo('Ruszor')
        player:addSpell(xi.magic.spell.STONE)
    end)

    it('lands a spell when not in an event', function()
        local hpBefore = mob:getHP()

        player.actions:useSpell(mob, xi.magic.spell.STONE)
        xi.test.world:skipTime(5)

        assert(mob:getHP() < hpBefore, 'control cast did not land')
    end)

    it('refuses a spell while in an event', function()
        player:startEvent(1)
        assert(player:isInEvent(), 'event did not start')

        local hpBefore = mob:getHP()

        player.actions:useSpell(mob, xi.magic.spell.STONE)
        xi.test.world:skipTime(5)

        assert(mob:getHP() >= hpBefore, 'spell landed during an event')
    end)

    it('refuses to engage while in an event', function()
        player:startEvent(1)

        player.actions:engage(mob)
        xi.test.world:skipTime(1)

        assert(not player:isEngaged(), 'engaged during an event')
    end)
end)
