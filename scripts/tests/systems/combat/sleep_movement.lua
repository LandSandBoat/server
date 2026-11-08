describe('Sleep movement', function()
    ---@type CClientEntityPair
    local player

    ---@type CTestEntity
    local mob

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE, job = xi.job.BLM, level = 99 })
        mob    = player.entities:moveTo('Wild_Rabbit')
        mob:respawn()
        mob:setMobMod(xi.mobMod.ROAM_COOL, 3600)
        xi.test.world:skipTime(5)
        local pos = player:getPos()
        mob:setPos(pos.x + 10, pos.y, pos.z, 0)
        xi.test.world:tick()
        mob:clearPath()
        player:addSpell(xi.magic.spell.SLEEP)
        player:addStatusEffect(xi.effect.CHAINSPELL, { power = 0, duration = 60, origin = player })
    end)

    local function sleepAndAssertStill()
        player.actions:useSpell(mob, xi.magic.spell.SLEEP)
        for _ = 1, 10 do
            if mob:hasStatusEffect(xi.effect.SLEEP_I) then
                break
            end

            xi.test.world:tick()
        end

        assert(mob:hasStatusEffect(xi.effect.SLEEP_I), 'mob should be asleep')

        local before = mob:getPos()
        for _ = 1, 5 do
            xi.test.world:tick()
        end

        local after = mob:getPos()
        assert(math.abs(after.x - before.x) < 0.01 and math.abs(after.z - before.z) < 0.01, string.format('mob moved %.2f/%.2f while asleep', after.x - before.x, after.z - before.z))
        assert(after.rot == before.rot, 'mob turned while asleep')
    end

    it('idle mob does not move when slept', function()
        sleepAndAssertStill()
    end)

    it('engaged mob does not move when slept', function()
        mob:updateEnmity(player)
        xi.test.world:tick()
        sleepAndAssertStill()
    end)
end)
