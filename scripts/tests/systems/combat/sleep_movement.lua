describe('Prevent-action movement', function()
    ---@type CClientEntityPair
    local player

    ---@type CTestEntity
    local mob

    -- Open ground on the navmesh. Other files leave the rabbits wherever they put them.
    local anchor = { x = -280.0, y = -55.19, z = 342.38 }

    local function placePlayer(offsetX)
        player:setPos(anchor.x + offsetX, anchor.y, anchor.z)
    end

    local roamCool

    before_each(function()
        player   = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE, job = xi.job.BLM, level = 99 })
        mob      = player.entities:moveTo('Wild_Rabbit')
        roamCool = mob:getMobMod(xi.mobMod.ROAM_COOL)
        mob:respawn()
        mob:setMobMod(xi.mobMod.ROAM_COOL, 3600)
        xi.test.world:skipTime(5)
        mob:setPos(anchor.x, anchor.y, anchor.z, 0)
        mob:clearPath()
        placePlayer(-20)
        player:addSpell(xi.magic.spell.SLEEP)
        player:addStatusEffect(xi.effect.CHAINSPELL, { power = 0, duration = 60, origin = player })
    end)

    -- Other files share these rabbits.
    after_each(function()
        mob:setMobMod(xi.mobMod.ROAM_COOL, roamCool)
        mob:delStatusEffect(xi.effect.SLEEP_I)
        mob:delStatusEffect(xi.effect.STUN)
    end)

    -- One tick puts a distant mob mid-chase, still well short of its target.
    local function engage()
        mob:updateEnmity(player)
        xi.test.world:tick()

        assert(mob:isEngaged(), 'mob should be engaged')
    end

    local function castSleep()
        player.actions:useSpell(mob, xi.magic.spell.SLEEP)
        for _ = 1, 10 do
            if mob:hasStatusEffect(xi.effect.SLEEP_I) then
                break
            end

            xi.test.world:tick()
        end

        assert(mob:hasStatusEffect(xi.effect.SLEEP_I), 'mob should be asleep')
    end

    local function assertStillFor(ticks, label)
        local before = mob:getPos()
        for _ = 1, ticks do
            xi.test.world:tick()
        end

        local after = mob:getPos()
        assert(math.abs(after.x - before.x) < 0.01 and math.abs(after.z - before.z) < 0.01, string.format('%s: mob moved %.2f/%.2f', label, after.x - before.x, after.z - before.z))
        assert(after.rot == before.rot, string.format('%s: mob turned from %d to %d', label, before.rot, after.rot))
    end

    local function tickUntilMoved(ticks)
        local before = mob:getPos()
        for _ = 1, ticks do
            xi.test.world:tick()
            local now = mob:getPos()
            if math.abs(now.x - before.x) > 0.1 or math.abs(now.z - before.z) > 0.1 then
                return true
            end
        end

        return false
    end

    describe('when slept', function()
        it('an idle mob does not move or turn', function()
            castSleep()
            assertStillFor(5, 'idle')
        end)

        it('a chasing mob does not move or turn', function()
            engage()
            castSleep()
            assertStillFor(5, 'chasing')
        end)

        it('an engaged mob keeps its target', function()
            engage()
            castSleep()
            xi.test.world:skipTime(3)

            assert(mob:isEngaged(), 'mob should still be engaged')
            assert(mob:getTarget() ~= nil and mob:getTarget():getID() == player:getID(), 'mob should keep its target')
        end)

        it('a mob in melee range does not attack', function()
            placePlayer(-1)
            engage()
            castSleep()

            local hp = player:getHP()
            for _ = 1, 5 do
                xi.test.world:skipTime(1)
            end

            assert(player:getHP() == hp, 'mob should not hit while asleep')
        end)

        it('a mob does not turn to a target that walks behind it', function()
            placePlayer(-2)
            engage()
            castSleep()

            placePlayer(2)
            assertStillFor(5, 'target behind')
            assert(not mob:isFacing(player), 'mob should not face a target behind it')
        end)

        it('a mob resumes chasing when it wakes', function()
            engage()
            castSleep()
            placePlayer(-20)
            mob:delStatusEffect(xi.effect.SLEEP_I)

            assert(tickUntilMoved(10), 'woken mob should chase')
            assert(mob:isFacing(player), 'woken mob should face its target')
        end)
    end)

    describe('when stunned', function()
        it('a chasing mob does not move or turn', function()
            engage()
            mob:addStatusEffect(xi.effect.STUN, { power = 1, duration = 60, origin = player })
            assertStillFor(5, 'stunned')
        end)

        it('a mob resumes chasing when the stun wears off', function()
            engage()
            mob:addStatusEffect(xi.effect.STUN, { power = 1, duration = 60, origin = player })
            xi.test.world:tick()
            placePlayer(-20)
            mob:delStatusEffect(xi.effect.STUN)

            assert(tickUntilMoved(10), 'mob should chase after the stun')
        end)
    end)

    describe('when awake', function()
        it('an engaged mob turns to a target that walks behind it', function()
            placePlayer(-2)
            engage()

            placePlayer(2)
            for _ = 1, 5 do
                xi.test.world:tick()
            end

            assert(mob:isFacing(player), 'awake mob should turn to its target')
        end)

        it('an engaged mob chases its target', function()
            engage()
            assert(tickUntilMoved(10), 'awake mob should chase')
        end)
    end)
end)
