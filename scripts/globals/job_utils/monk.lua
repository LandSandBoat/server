-----------------------------------
-- Monk Job Utilities
-----------------------------------
xi = xi or {}
xi.job_utils = xi.job_utils or {}
xi.job_utils.monk = xi.job_utils.monk or {}

local chakraStatusEffects =
{
    POISON       = 0, -- Removed by default
    BLINDNESS    = 0, -- Removed by default
    PARALYSIS    = 1,
    DISEASE      = 2,
    PLAGUE       = 4,
}

-----------------------------------
-- Ability Check Functions
-----------------------------------
xi.job_utils.monk.checkHundredFists = function(player, target, ability)
    ability:setRecast(math.max(0, ability:getRecast() - player:getMod(xi.mod.ONE_HOUR_RECAST) * 60))
    return 0, 0
end

xi.job_utils.monk.checkInnerStrength = function(player, target, ability)
    ability:setRecast(math.max(0, ability:getRecast() - player:getMod(xi.mod.ONE_HOUR_RECAST) * 60))
    return 0, 0
end

-----------------------------------
-- Ability Use Functions
-----------------------------------
xi.job_utils.monk.useBoost = function(player, target, ability)
    local power = 12.5 + (0.10 * player:getMod(xi.mod.BOOST_EFFECT))

    if player:hasStatusEffect(xi.effect.BOOST) then
        local effect = player:getStatusEffect(xi.effect.BOOST)

        effect:setPower(effect:getPower() + power) -- Store updated power in boost for zoning
        effect:addMod(xi.mod.ATTP, power)
    else
        player:addStatusEffect(xi.effect.BOOST, { power = power, duration = 180, origin = player })
    end
end

-- TODO: add Melee Gloves +2 aug
xi.job_utils.monk.useChakra = function(player, target, ability)
    local chakraRemoval = player:getMod(xi.mod.CHAKRA_REMOVAL)

    for k, v in pairs(chakraStatusEffects) do
        if bit.band(chakraRemoval, v) == v then
            player:delStatusEffect(xi.effect[k])
        end
    end

    -- see https://www.bg-wiki.com/ffxi/Chakra
    local monkLevel         = utils.getActiveJobLevel(player, xi.job.MNK)
    local jpModifier        = target:getJobPointLevel(xi.jp.CHAKRA_EFFECT) -- NOTE: Level is the modified value, so 10 per point spent
    local hpModifier        = ((monkLevel + 1) * 0.2 / 100) * player:getMaxHP()
    local chakraMultiplier  = 1 + player:getMod(xi.mod.CHAKRA_MULT) / 100
    local maxRecoveryAmount = (player:getStat(xi.mod.VIT) * 2 + hpModifier) * chakraMultiplier + jpModifier
    local recoveryAmount    = math.min(player:getMaxHP() - player:getHP(), maxRecoveryAmount)

    player:setHP(player:getHP() + recoveryAmount)

    local merits = player:getMerit(xi.merit.INVIGORATE)
    if merits > 0 then
        if player:hasStatusEffect(xi.effect.REGEN) then
            player:delStatusEffect(xi.effect.REGEN)
        end

        player:addStatusEffect(xi.effect.REGEN, { power = 10, duration = merits, origin = player, tier = 1 })
    end

    return recoveryAmount
end

xi.job_utils.monk.useChiBlast = function(player, target, ability)
    local penanceMerits = player:getMerit(xi.merit.PENANCE) -- 20/40/60/80/100
    if penanceMerits > 0 then
        target:delStatusEffectSilent(xi.effect.INHIBIT_TP)
        target:addStatusEffect(xi.effect.INHIBIT_TP, { power = 25, duration = penanceMerits, origin = player })
    end

    local boost = player:getStatusEffect(xi.effect.BOOST)
    local multiplier = 1.0
    if boost ~= nil then
        multiplier = (boost:getPower() / 100) * 4 -- power is the raw % atk boost
    end

    local dmg = math.floor(player:getStat(xi.mod.MND) * (0.5 + (math.random() / 2))) * multiplier

    dmg = xi.ability.adjustDamage(dmg, player, ability, target, xi.attackType.BREATH, xi.damageType.ELEMENTAL, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, player, xi.attackType.BREATH, xi.damageType.ELEMENTAL)
    target:updateClaim(player)
    player:delStatusEffect(xi.effect.BOOST)

    return dmg
end

xi.job_utils.monk.useCounterstance = function(player, target, ability)
    target:delStatusEffect(xi.effect.COUNTERSTANCE)

    local pTable =
    {
        power    = 45 + player:getMod(xi.mod.COUNTERSTANCE_EFFECT),
        duration = 300,
        origin   = player,
    }

    target:addStatusEffect(xi.effect.COUNTERSTANCE, pTable)

    return xi.effect.COUNTERSTANCE
end

xi.job_utils.monk.useDodge = function(player, target, ability)
    local pTable =
    {
        power    = target:getMod(xi.mod.DODGE_EFFECT) + target:getJobPointLevel(xi.jp.DODGE_EFFECT),
        duration = 30,
        origin   = player,
    }

    player:addStatusEffect(xi.effect.DODGE, pTable)

    return xi.effect.DODGE
end

xi.job_utils.monk.useFocus = function(player, target, ability)
    local pTable =
    {
        power    = target:getMod(xi.mod.FOCUS_EFFECT) + target:getJobPointLevel(xi.jp.FOCUS_EFFECT),
        duration = 30,
        origin   = player,
    }

    player:addStatusEffect(xi.effect.FOCUS, pTable)

    return xi.effect.FOCUS
end

xi.job_utils.monk.useFootwork = function(player, target, ability)
    local pTable =
    {
        power    = 20 + player:getWeaponDmg(),
        duration = 60,
        subPower = 25 + player:getMod(xi.mod.FOOTWORK_ATT_BONUS),
        origin   = player,
    }

    player:addStatusEffect(xi.effect.FOOTWORK, pTable)

    return xi.effect.FOOTWORK
end

xi.job_utils.monk.useFormlessStrikes = function(player, target, ability)
    local pTable =
    {
        power    = 1,
        duration = 180,
        origin   = player,
    }

    player:addStatusEffect(xi.effect.FORMLESS_STRIKES, pTable)

    return xi.effect.FORMLESS_STRIKES
end

xi.job_utils.monk.useHundredFists = function(player, target, ability)
    local pTable =
    {
        power    = 1,
        duration = 45,
        origin   = player,
    }

    player:addStatusEffect(xi.effect.HUNDRED_FISTS, pTable)

    return xi.effect.HUNDRED_FISTS
end

xi.job_utils.monk.useImpetus = function(player, target, ability)
    local pTable =
    {
        power    = 0,
        subPower = player:getMod(xi.mod.AUGMENTS_IMPETUS), -- Determines what extra bonuses we get.
        duration = 180,
        origin   = player,
    }

    player:addStatusEffect(xi.effect.IMPETUS, pTable)

    return xi.effect.IMPETUS
end

xi.job_utils.monk.useInnerStrength = function(player, target, ability)
    local pTable =
    {
        power    = 2,
        duration = 30,
        origin   = player,
    }

    player:addStatusEffect(xi.effect.INNER_STRENGTH, pTable)

    return xi.effect.INNER_STRENGTH
end

xi.job_utils.monk.useMantra = function(player, target, ability)
    target:delStatusEffect(xi.effect.MAX_HP_BOOST) -- TODO: confirm which versions of HP boost mantra can overwrite

    local pTable =
    {
        power    = player:getMerit(xi.merit.MANTRA),
        duration = 180,
        origin   = player,
    }

    target:addStatusEffect(xi.effect.MAX_HP_BOOST, pTable)

    return xi.effect.MAX_HP_BOOST
end

xi.job_utils.monk.usePerfectCounter = function(player, target, ability)
    local pTable =
    {
        power    = 2,
        duration = 30,
        origin   = player,
    }

    player:addStatusEffect(xi.effect.PERFECT_COUNTER, pTable)

    return xi.effect.PERFECT_COUNTER
end
