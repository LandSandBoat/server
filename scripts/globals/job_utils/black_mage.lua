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
-- caster's current TP (floor(TP / 10)), which is spent when the ability is used.
xi.job_utils.black_mage.calculateCascadeMagicDamage = function(player, tp)
    return math.floor(tp / 10)
end

-- Consumes the Cascade buff for an elemental damage spell, returning the stored Magic Damage bonus.
-- Only elemental magic that deals damage consumes Cascade; spells that do not benefit from Magic
-- Damage (cures, enfeebles such as Burn/Frost, weapon skills, divine magic, etc.) leave it intact.
xi.job_utils.black_mage.tryConsumeCascade = function(caster, skillType)
    if
        skillType ~= xi.skill.ELEMENTAL_MAGIC or
        not caster:hasStatusEffect(xi.effect.CASCADE)
    then
        return 0
    end

    local bonus = caster:getStatusEffect(xi.effect.CASCADE):getPower()
    caster:delStatusEffectSilent(xi.effect.CASCADE)

    return bonus
end

xi.job_utils.black_mage.useCascade = function(player, target, ability)
    local tp    = player:getTP()
    local bonus = xi.job_utils.black_mage.calculateCascadeMagicDamage(player, tp)

    -- Spend all current TP and store the resulting magic damage bonus on the buff.
    player:delTP(tp)
    player:addStatusEffect(xi.effect.CASCADE, { power = bonus, duration = 60, origin = player })

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
