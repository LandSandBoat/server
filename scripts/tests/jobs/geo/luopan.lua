describe('Luopan abilities', function()
    ---@type CClientEntityPair
    local player
    ---@type CTestEntity
    local mob

    local function spawnWithLuopan(level)
        player = xi.test.world:spawnPlayer({ zone = xi.zone.BEAUCEDINE_GLACIER_S, job = xi.job.GEO, level = level })
        mob    = player.entities:moveTo('Ruszor')

        player:addSpell(xi.magic.spell.GEO_REFRESH)
        player:setMP(500)
        player.actions:useSpell(player, xi.magic.spell.GEO_REFRESH)
        xi.test.world:skipTime(10)
        xi.test.world:skipTime(5)
        assert(player:hasPet(), 'luopan was not summoned')
    end

    -- the pulse kills the luopan through a timer, so it takes a few ticks to land
    local function pulse()
        player.actions:useAbility(mob, xi.jobAbility.CONCENTRIC_PULSE)
        for _ = 1, 4 do
            xi.test.world:skipTime(2)
        end
    end

    it('refuses Concentric Pulse below its level', function()
        spawnWithLuopan(89)
        pulse()

        assert(player:hasPet() and player:getPet():getHP() > 0, 'Concentric Pulse was used before it was learned')
    end)

    it('allows Concentric Pulse once learned', function()
        spawnWithLuopan(90)
        pulse()

        assert(not player:hasPet() or player:getPet():getHP() == 0, 'Concentric Pulse did not consume the luopan')
    end)
end)
