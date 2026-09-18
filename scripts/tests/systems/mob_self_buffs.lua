describe('Mob self buffs', function()
    local player
    local mob
    local mobHome
    local mobMagicCool
    local ally
    local allyHome
    local extraAlly
    local extraHome

    -- Castle Oztroja is dense with yagudo that would qualify as buff allies, so each case runs far away from all of them.
    local isolationOffset = 600

    -- A cast only completes on a later tick, so time is advanced in steps rather than one jump.
    local function skipTimeInSteps(seconds)
        for _ = 1, seconds / 10 do
            xi.test.world:skipTime(10)
        end
    end

    -- The magic state casts from a per-cast copy of the spell, so a spied spell object is stale by the time a test reads it.
    -- Ids are captured at call time instead.
    local casts

    local function recordCasts()
        casts = {}
        local record = function(caster, target, spell)
            table.insert(casts, { caster = caster:getID(), target = target:getID(), spell = spell:getID() })
        end

        stub('xi.spells.enhancing.useEnhancingSpell'):sideEffect(record)
        stub('xi.spells.enhancing.useEnhancingSong'):sideEffect(record)
    end

    local function castsOf(caster, spellId, target)
        local count = 0
        for _, cast in ipairs(casts) do
            local sameCaster = cast.caster == caster:getID()
            local sameSpell  = spellId == nil or cast.spell == spellId
            local sameTarget = target == nil or cast.target == target:getID()
            if sameCaster and sameSpell and sameTarget then
                count = count + 1
            end
        end

        return count
    end

    local function castsBy(caster)
        return castsOf(caster)
    end

    local function describeCasts()
        local lines = {}
        for _, cast in ipairs(casts) do
            if cast.caster == mob:getID() then
                table.insert(lines, string.format('spell %d -> %d', cast.spell, cast.target))
            end
        end

        return table.concat(lines, '; ')
    end

    local function allyRange()
        return 3.5 * (mob:getHitboxSize() + ally:getHitboxSize())
    end

    local function placeNear(entity, distance)
        local pos = mob:getPos()
        entity:setPos(pos.x + distance, pos.y, pos.z)
    end

    local function stripBuffs(entity)
        for _, effect in ipairs({ xi.effect.PROTECT, xi.effect.SHELL, xi.effect.HASTE, xi.effect.STONESKIN, xi.effect.BLINK, xi.effect.AQUAVEIL }) do
            entity:delStatusEffect(effect)
        end
    end

    local function saturate(entity, protectTier, shellTier)
        stripBuffs(entity)
        entity:addStatusEffect(xi.effect.PROTECT, { power = 220, duration = 3600, origin = entity, tier = protectTier })
        entity:addStatusEffect(xi.effect.SHELL, { power = 2930, duration = 3600, origin = entity, tier = shellTier })
        entity:addStatusEffect(xi.effect.HASTE, { power = 1465, duration = 3600, origin = entity, tier = 5 })
    end

    -- A pinned mob neither roams nor despawns for standing far from its spawn point or off the navmesh.
    local function pin(entity)
        entity:setMobMod(xi.mobMod.NO_MOVE, 1)
        entity:setMobMod(xi.mobMod.DONT_ROAM_HOME, 1)
        entity:setMobMod(xi.mobMod.NO_DESPAWN, 1)
    end

    local function unpin(entity)
        entity:setMobMod(xi.mobMod.NO_MOVE, 0)
        entity:setMobMod(xi.mobMod.DONT_ROAM_HOME, 0)
        entity:setMobMod(xi.mobMod.NO_DESPAWN, 0)
    end

    local function quiet(entity)
        entity:respawn()
        entity:clearPath()
        entity:setMagicCastingEnabled(false)
        pin(entity)
    end

    local function restore(entity, home)
        entity:setMagicCastingEnabled(true)
        unpin(entity)
        stripBuffs(entity)
        entity:setPos(home.x, home.y, home.z)
    end

    -- A second same-family ally, parked at the given distance and put back by after_each even when a case fails.
    local function useExtraAlly(distance)
        extraAlly = player.entities:get('Yagudo_Votary')
        extraHome = extraAlly:getPos()
        quiet(extraAlly)
        placeNear(extraAlly, distance)

        return extraAlly
    end

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.CASTLE_OZTROJA })
        mob = player.entities:moveTo('Yagudo_Priest')
        mobMagicCool = mob:getMobMod(xi.mobMod.MAGIC_COOL)

        -- Keep the yagudo around the priest from engaging and dragging it into combat.
        player:addStatusEffect(xi.effect.INVISIBLE, { duration = 3600, origin = player })
        player:addStatusEffect(xi.effect.SNEAK, { duration = 3600, origin = player })

        recordCasts()

        mob:respawn()
        mob:clearPath()
        stripBuffs(mob)
        mob:setSpellList(97) -- Stoneskin only
        pin(mob)
        mobHome = mob:getPos()
        mob:setPos(mobHome.x + isolationOffset, mobHome.y, mobHome.z)
        player:setPos(mobHome.x + isolationOffset + 3, mobHome.y, mobHome.z)

        -- Same family as the priest; parked out of range and fully buffed until a case says otherwise.
        ally = player.entities:get('Yagudo_Theologist')
        allyHome = ally:getPos()
        quiet(ally)
        saturate(ally, 5, 5)
        placeNear(ally, allyRange() + 5)
    end)

    after_each(function()
        mob:setMobMod(xi.mobMod.MAGIC_COOL, mobMagicCool)
        restore(mob, mobHome)
        restore(ally, allyHome)
        if extraAlly then
            restore(extraAlly, extraHome)
            extraAlly = nil
        end
    end)

    it('casts a buff it does not have', function()
        skipTimeInSteps(60)

        assert(mob:hasStatusEffect(xi.effect.STONESKIN), 'idle mob has cast Stoneskin')
    end)

    it('does not recast a buff that is still active', function()
        skipTimeInSteps(180)

        assert(castsBy(mob) == 1, string.format('expected 1 Stoneskin cast, got %d', castsBy(mob)))
    end)

    it('does not cast a buff it already has from another source', function()
        mob:addStatusEffect(xi.effect.STONESKIN, { power = 100, duration = 600, origin = mob })

        skipTimeInSteps(120)

        assert(castsBy(mob) == 0, string.format('expected no Stoneskin cast, got %d', castsBy(mob)))
    end)

    it('casts the buff again once it wears off', function()
        skipTimeInSteps(60)
        mob:delStatusEffect(xi.effect.STONESKIN)
        skipTimeInSteps(90)

        assert(castsBy(mob) == 2, string.format('expected 2 Stoneskin casts, got %d', castsBy(mob)))
    end)

    it('upgrades a lower tier of a buff it already has', function()
        mob:setSpellList(203) -- Protect IV, Shell III
        mob:addStatusEffect(xi.effect.PROTECT, { power = 50, duration = 600, origin = mob, tier = 2 })
        mob:addStatusEffect(xi.effect.SHELL, { power = 2188, duration = 600, origin = mob, tier = 3 })

        skipTimeInSteps(60)

        assert(castsOf(mob, xi.magic.spell.PROTECT_IV, mob) == 1, string.format('expected 1 Protect IV cast, got %d [%s]', castsOf(mob, xi.magic.spell.PROTECT_IV, mob), describeCasts()))
        assert(mob:getStatusEffect(xi.effect.PROTECT):getTier() == 4, 'Protect on the mob should be tier 4 after the upgrade')
    end)

    it('does not recast an equal or higher tier', function()
        mob:setSpellList(203)
        mob:addStatusEffect(xi.effect.PROTECT, { power = 220, duration = 600, origin = mob, tier = 5 })
        mob:addStatusEffect(xi.effect.SHELL, { power = 2188, duration = 600, origin = mob, tier = 3 })

        skipTimeInSteps(60)

        assert(castsBy(mob) == 0, string.format('expected no cast over equal or higher tiers, got %d', castsBy(mob)))
    end)

    it('recasts Aquaveil while it is still active', function()
        mob:setSpellList(455) -- Protect III, Shell III, Blink, Aquaveil, Haste
        saturate(mob, 3, 3)
        mob:addStatusEffect(xi.effect.BLINK, { power = 2, duration = 3600, origin = mob })
        assert(mob:hasStatusEffect(xi.effect.BLINK), 'setup: Blink should be on the mob')

        skipTimeInSteps(150)

        assert(castsOf(mob, xi.magic.spell.AQUAVEIL, mob) >= 2, string.format('expected repeated Aquaveil casts, got %d [%s]', castsOf(mob, xi.magic.spell.AQUAVEIL, mob), describeCasts()))
        assert(castsBy(mob) == castsOf(mob, xi.magic.spell.AQUAVEIL, mob), 'only Aquaveil should have been recast [' .. describeCasts() .. ']')
    end)

    it('buffs a nearby ally that lacks a party buff', function()
        mob:setSpellList(203)
        saturate(mob, 4, 3)
        ally:delStatusEffect(xi.effect.PROTECT)
        ally:addStatusEffect(xi.effect.PROTECT, { power = 50, duration = 600, origin = ally, tier = 2 })
        placeNear(ally, allyRange() - 2)

        skipTimeInSteps(60)

        assert(castsOf(mob, xi.magic.spell.PROTECT_IV, ally) == 1, string.format('expected 1 Protect IV on the ally, got %d [%s]', castsOf(mob, xi.magic.spell.PROTECT_IV, ally), describeCasts()))
        assert(castsOf(mob, xi.magic.spell.SHELL_III, ally) == 0, 'the ally already has a higher Shell')
        assert(ally:getStatusEffect(xi.effect.PROTECT):getTier() == 4, 'Protect on the ally should be tier 4 after the upgrade')
    end)

    it('does not upgrade an ally that already has a higher tier', function()
        mob:setSpellList(203)
        saturate(mob, 4, 3)
        placeNear(ally, allyRange() - 2)

        skipTimeInSteps(60)

        assert(castsBy(mob) == 0, string.format('expected no cast on a fully buffed ally, got %d', castsBy(mob)))
    end)

    it('buffs the nearest lacking ally', function()
        mob:setSpellList(203)
        saturate(mob, 4, 3)

        local farAlly = ally
        local nearAlly = useExtraAlly(4)
        saturate(nearAlly, 5, 2)
        farAlly:delStatusEffect(xi.effect.SHELL)
        farAlly:addStatusEffect(xi.effect.SHELL, { power = 1641, duration = 600, origin = farAlly, tier = 2 })
        placeNear(farAlly, 8)

        skipTimeInSteps(60)

        assert(castsOf(mob, xi.magic.spell.SHELL_III, nearAlly) == 1, string.format('expected Shell III on the nearest ally, got %d [%s]', castsOf(mob, xi.magic.spell.SHELL_III, nearAlly), describeCasts()))
        assert(castsOf(mob, xi.magic.spell.SHELL_III, farAlly) == 0, 'the farther ally should not have been picked first')
    end)

    it('shares the pick evenly between itself and each lacking ally, nearest ally first', function()
        mob:setSpellList(203)
        mob:setMobMod(xi.mobMod.MAGIC_COOL, 2)

        local farAlly = ally
        local nearAlly = useExtraAlly(4)
        placeNear(farAlly, 8)

        -- Everyone keeps Protect and lacks Shell III, so each cast is a three-way choice for the same spell.
        local function resetShell()
            for _, entity in ipairs({ mob, nearAlly, farAlly }) do
                entity:delStatusEffect(xi.effect.SHELL)
                entity:addStatusEffect(xi.effect.PROTECT, { power = 220, duration = 3600, origin = entity, tier = 5 })
            end

            mob:setMP(mob:getMaxMP())
        end

        resetShell()

        local trials = 300
        local seen = 0
        local steps = 0
        while seen < trials and steps < trials * 20 do
            xi.test.world:skipTime(1)
            steps = steps + 1
            if castsBy(mob) > seen then
                seen = castsBy(mob)
                resetShell()
            end
        end

        assert(seen == trials, string.format('setup: expected %d casts, got %d', trials, seen))

        -- One third each on average; the 4-sigma window excludes a fixed coin flip (150) and self-first (300).
        local selfCasts = castsOf(mob, xi.magic.spell.SHELL_III, mob)
        assert(selfCasts >= 67 and selfCasts <= 133, string.format('expected about 100 of 300 casts on self, got %d', selfCasts))
        assert(castsOf(mob, xi.magic.spell.SHELL_III, farAlly) == 0, string.format('the farther ally should never be picked, got %d', castsOf(mob, xi.magic.spell.SHELL_III, farAlly)))
        assert(castsOf(mob, xi.magic.spell.SHELL_III, nearAlly) == trials - selfCasts, 'every ally cast should have gone to the nearest ally')
    end)

    it('never buffs a mob outside its link party', function()
        mob:setSpellList(203)
        saturate(mob, 4, 3)

        -- Bats do not link, so the bat sits in its own party even though it lacks everything.
        extraAlly = player.entities:get('Bastion_Bats')
        extraHome = extraAlly:getPos()
        quiet(extraAlly)
        placeNear(extraAlly, 3)

        skipTimeInSteps(60)

        assert(castsBy(mob) == 0, string.format('expected no cast on a mob from another link party, got %d [%s]', castsBy(mob), describeCasts()))
    end)

    it('keeps singing while its songs are still up', function()
        mob:setSpellList(6) -- Beastmen BRD songs by level

        skipTimeInSteps(150)

        assert(castsBy(mob) >= 3, string.format('expected the bard to keep singing, got %d casts [%s]', castsBy(mob), describeCasts()))
    end)

    it('gives a bar-element spell 150 seconds when a mob casts it', function()
        mob:castSpell(xi.magic.spell.BARWATER, mob)
        for _ = 1, 10 do
            xi.test.world:skipTime(1)
        end

        local barwater = mob:getStatusEffect(xi.effect.BARWATER)
        assert(barwater, 'setup: Barwater should have landed on the mob')
        assert(barwater:getDuration() == 150000, string.format('expected a 150 s Barwater, got %d ms', barwater:getDuration()))
    end)

    it('ignores allies out of range', function()
        mob:setSpellList(203)
        saturate(mob, 4, 3)
        ally:delStatusEffect(xi.effect.PROTECT)
        ally:addStatusEffect(xi.effect.PROTECT, { power = 50, duration = 600, origin = ally, tier = 2 })
        placeNear(ally, allyRange() + 2)

        skipTimeInSteps(60)

        assert(castsBy(mob) == 0, string.format('expected no cast on an ally out of range, got %d', castsBy(mob)))
    end)

    it('never casts a self-only buff on an ally', function()
        mob:addStatusEffect(xi.effect.STONESKIN, { power = 100, duration = 600, origin = mob })
        placeNear(ally, allyRange() - 2)

        skipTimeInSteps(60)

        assert(castsBy(mob) == 0, string.format('expected no Stoneskin on the ally, got %d', castsBy(mob)))
    end)

    it('does not cast while walking', function()
        -- Walking needs the navmesh, so this case runs at the spawn point; a self-only list keeps the neighbours out of it.
        mob:setPos(mobHome.x, mobHome.y, mobHome.z)

        -- Let the first Stoneskin land and the cooldown run out, then take the buff away with a walk queued.
        skipTimeInSteps(60)
        assert(castsBy(mob) == 1, 'setup: expected the first Stoneskin cast')
        mob:delStatusEffect(xi.effect.STONESKIN)
        mob:setMobMod(xi.mobMod.NO_MOVE, 0)

        local pos = mob:getPos()
        local points = {}
        for i = 1, 6 do
            local sign = 1
            if i % 2 == 0 then
                sign = -1
            end

            table.insert(points, { x = pos.x + sign * 10, y = pos.y, z = pos.z })
        end

        mob:pathThrough(points, xi.pathflag.COORDS)
        assert(mob:isFollowingPath(), 'setup: the mob should be walking the path')

        local stepsWalked = 0
        while mob:isFollowingPath() and stepsWalked < 120 do
            xi.test.world:skipTime(1)
            stepsWalked = stepsWalked + 1
            assert(castsBy(mob) == 1, string.format('cast while walking at step %d', stepsWalked))
        end

        assert(stepsWalked >= 3, 'setup: the path should take several steps')
        mob:setMobMod(xi.mobMod.NO_MOVE, 1)

        skipTimeInSteps(40)

        assert(castsBy(mob) == 2, string.format('expected the delayed Stoneskin cast after the walk, got %d', castsBy(mob)))
    end)

    it('waits the magic cooldown between idle casts', function()
        mob:setSpellList(455)

        -- A tick is longer than the second skipTime adds, so gaps are read off a long effect's remaining time rather than counted in steps.
        local clock = player:getStatusEffect(xi.effect.INVISIBLE)
        local castTimes = {}
        local seen = 0
        for _ = 1, 150 do
            xi.test.world:skipTime(1)
            local count = castsBy(mob)
            if count > seen then
                seen = count
                table.insert(castTimes, clock:getTimeRemaining() / 1000)
            end
        end

        assert(#castTimes >= 3, string.format('expected at least 3 casts, got %d', #castTimes))
        for i = 2, #castTimes do
            local gap = castTimes[i - 1] - castTimes[i]
            assert(gap >= 17, string.format('casts %d and %d were only %.1f s apart', i - 1, i, gap))
        end
    end)
end)
