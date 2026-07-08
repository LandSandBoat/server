-- Coverage for prevent-action interrupts of a casting entity.
--
-- Original bug (UAF -> crash): a sleep landing while an entity resolved its own cast
-- tore the running CMagicState out from under its own DoUpdate -> heap-use-after-free.
--
-- A MAGIC_USE listener fires only when a cast actually completes, so it's a reliable
-- "did the spell go off?" signal.

describe('Action interrupts', function()
    -- CLuaBaseEntity::getCurrentAction() values
    local actionMagicCasting = 30
    local actionSleep        = 27 -- inactive due to a prevent-action effect

    ---@type CClientEntityPair
    local caster

    ---@type CTestEntity
    local target

    before_each(function()
        caster = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE, job = xi.job.BLM, level = 99 })
        target = caster.entities:moveTo('Wild_Rabbit')
        target:respawn() -- reset to full HP/alive; a prior test's cast may have killed it
        local pos = caster:getPos()
        target:setPos(pos.x, pos.y, pos.z)
        caster:addSpell(xi.magic.spell.STONE)
    end)

    -- Advance enough for a cast to finish and the (completed or interrupted) magic state
    -- to retire and the entity to settle into its next state.
    local function settle()
        for _ = 1, 5 do
            xi.test.world:skipTime(3)
        end
    end

    it('completes a cast normally when nothing prevents it', function()
        caster:addStatusEffect(xi.effect.CHAINSPELL, { power = 0, duration = 60, origin = caster })

        local completed = false
        caster:addListener('MAGIC_USE', 'TEST_USE', function()
            completed = true
        end)

        caster.actions:useSpell(target, xi.magic.spell.STONE)
        settle()

        caster:removeListener('TEST_USE')

        assert(completed, 'cast should complete')
        assert(caster:getCurrentAction() ~= actionSleep, 'caster should not be inactive')
    end)

    it('does not crash when slept during its own cast resolution; the cast still completes', function()
        caster:addStatusEffect(xi.effect.CHAINSPELL, { power = 0, duration = 60, origin = caster })

        local completed = false
        caster:addListener('MAGIC_USE', 'TEST_USE', function()
            completed = true
        end)

        target:addListener('MAGIC_TAKE', 'TEST_SLEEP', function(_, magicCaster)
            magicCaster:addStatusEffect(xi.effect.SLEEP_I, { power = 1, duration = 60, origin = magicCaster })
        end)

        caster.actions:useSpell(target, xi.magic.spell.STONE)
        settle()

        caster:removeListener('TEST_USE')
        target:removeListener('TEST_SLEEP')

        assert(completed, 'cast should complete (the sleep lands at the finish, after the check)')
        assert(caster:hasStatusEffect(xi.effect.SLEEP_I), 'caster should be asleep')
        assert(caster:getCurrentAction() == actionSleep, 'caster should be parked inactive afterward')
    end)

    it('does not cancel a cast mid-flight; it interrupts at the finish', function()
        local completed = false
        caster:addListener('MAGIC_USE', 'TEST_USE', function()
            completed = true
        end)

        caster.actions:useSpell(target, xi.magic.spell.STONE)

        -- Land the sleep while the (non-instant) cast is still in progress.
        caster:addStatusEffect(xi.effect.SLEEP_I, { power = 1, duration = 60, origin = caster })

        -- One partial tick: the cast must still be running -- the sleep does not cancel it.
        xi.test.world:tickEntity(caster)
        assert(caster:getCurrentAction() == actionMagicCasting, 'sleep must not cancel a cast mid-flight')

        -- Now let it reach its finish, where the prevent-action effect interrupts it.
        settle()

        caster:removeListener('TEST_USE')

        assert(not completed, 'cast should be interrupted at its finish, not completed')
        assert(caster:hasStatusEffect(xi.effect.SLEEP_I), 'caster should be asleep')
        assert(caster:getCurrentAction() == actionSleep, 'caster should be parked inactive')
    end)

    it('does not interrupt a cast if the stun wears off before the finish', function()
        local completed = false
        caster:addListener('MAGIC_USE', 'TEST_USE', function()
            completed = true
        end)

        caster.actions:useSpell(target, xi.magic.spell.STONE) -- ~2s cast (no Chainspell)

        -- Stun mid-cast, short enough to wear off well before the cast would complete.
        caster:addStatusEffect(xi.effect.STUN, { power = 1, duration = 1, origin = caster })

        settle() -- the 1s stun wears off well before the cast's finish check

        caster:removeListener('TEST_USE')

        assert(completed, 'cast should complete -- the stun wore off before the finish')
        assert(not caster:hasStatusEffect(xi.effect.STUN), 'stun should have worn off')
    end)

    it('parks a non-casting entity inactive when a prevent-action effect lands', function()
        assert(caster:getCurrentAction() ~= actionSleep, 'precondition: caster is not already inactive')

        caster:addStatusEffect(xi.effect.SLEEP_I, { power = 1, duration = 60, origin = caster })
        xi.test.world:tickEntity(caster)

        assert(caster:hasStatusEffect(xi.effect.SLEEP_I), 'caster should be asleep')
        assert(caster:getCurrentAction() == actionSleep, 'idle caster should be parked inactive by the poll')
    end)
end)
