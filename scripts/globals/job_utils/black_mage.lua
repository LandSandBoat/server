-----------------------------------
-- Black Mage Job Utilities
-----------------------------------
xi = xi or {}
xi.job_utils = xi.job_utils or {}
xi.job_utils.black_mage = xi.job_utils.black_mage or {}

-----------------------------------
-- Ability Check Functions
-----------------------------------
xi.job_utils.black_mage.checkManafont = function(player, target, ability)
    ability:setRecast(math.max(0, ability:getRecast() - player:getMod(xi.mod.ONE_HOUR_RECAST) * 60))
    return 0, 0
end

xi.job_utils.black_mage.checkSubtleSorcery = function(player, target, ability)
    ability:setRecast(math.max(0, ability:getRecast() - player:getMod(xi.mod.ONE_HOUR_RECAST) * 60))
    return 0, 0
end

-----------------------------------
-- Ability Use Functions
-----------------------------------
-- Cascade grants a Magic Damage bonus to the next elemental magic spell, equal to 10% of the
-- caster's current TP (floor(TP / 10)). The TP is not spent until that spell is cast.
xi.job_utils.black_mage.calculateCascadeMagicDamage = function(player, tp)
    return math.floor(tp / 10)
end

-- Returns the Magic Damage bonus from an active Cascade buff for an elemental damage spell, or 0
-- when it does not apply. This only reads the buff; it is consumed separately by tryConsumeCascade
-- so that every target of an AoE (-ga) spell receives the bonus.
xi.job_utils.black_mage.getCascadeMagicDamage = function(caster, skillType)
    if
        skillType ~= xi.skill.ELEMENTAL_MAGIC or
        not caster:hasStatusEffect(xi.effect.CASCADE)
    then
        return 0
    end

    return caster:getStatusEffect(xi.effect.CASCADE):getPower()
end

-- Consumes the Cascade buff after an elemental damage spell is cast: spends the TP captured on use
-- and removes the buff. The work is deferred to a zero-delay timer and guarded so it is scheduled
-- only once, so it runs after every target of an AoE spell has been damaged. This matches retail,
-- where all targets are boosted and the buff wears off at the very end. Only elemental damage spells
-- consume Cascade; cures, dark magic (e.g. Drain), enfeebles and other schools leave it intact.
xi.job_utils.black_mage.tryConsumeCascade = function(caster, skillType)
    if
        skillType ~= xi.skill.ELEMENTAL_MAGIC or
        not caster:hasStatusEffect(xi.effect.CASCADE) or
        caster:getLocalVar('cascadeConsuming') ~= 0
    then
        return
    end

    caster:setLocalVar('cascadeConsuming', 1)

    caster:timer(0, function(casterArg)
        local cascadeEffect = casterArg:getStatusEffect(xi.effect.CASCADE)
        if cascadeEffect then
            casterArg:delTP(cascadeEffect:getSubPower())
            casterArg:delStatusEffectSilent(xi.effect.CASCADE)
        end

        casterArg:setLocalVar('cascadeConsuming', 0)
    end)
end

xi.job_utils.black_mage.useCascade = function(player, target, ability)
    local tp    = player:getTP()
    local bonus = xi.job_utils.black_mage.calculateCascadeMagicDamage(player, tp)

    -- Store the bonus (power) and the TP to spend (subPower). The TP is not consumed until the
    -- buffed elemental spell is cast; see tryConsumeCascade.
    player:setLocalVar('cascadeConsuming', 0)
    player:addStatusEffect(xi.effect.CASCADE, { power = bonus, subPower = tp, duration = 60, origin = player })

    return xi.effect.CASCADE
end

xi.job_utils.black_mage.useElementalSeal = function(player, target, ability)
    player:addStatusEffect(xi.effect.ELEMENTAL_SEAL, { power = 1, duration = 60, origin = player })

    return xi.effect.ELEMENTAL_SEAL
end

xi.job_utils.black_mage.useEnmityDouse = function(player, target, ability)
    if target:isMob() then
        target:setCE(player, 1)
        target:setVE(player, 0)
    end
end

xi.job_utils.black_mage.useManafont = function(player, target, ability)
    player:addStatusEffect(xi.effect.MANAFONT, { power = 1, duration = 60, origin = player })

    return xi.effect.MANAFONT
end

xi.job_utils.black_mage.useManaWall = function(player, target, ability)
    player:addStatusEffect(xi.effect.MANA_WALL, { power = 1, duration = 300, origin = player })

    return xi.effect.MANA_WALL
end

xi.job_utils.black_mage.useManawell = function(player, target, ability)
    target:addStatusEffect(xi.effect.MANAWELL, { power = 1, duration = 60, origin = player })

    return xi.effect.MANAWELL
end

xi.job_utils.black_mage.useSubtleSorcery = function(player, target, ability)
    player:addStatusEffect(xi.effect.SUBTLE_SORCERY, { power = 1, duration = 60, origin = player })

    return xi.effect.SUBTLE_SORCERY
end
