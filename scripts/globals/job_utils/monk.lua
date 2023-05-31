-----------------------------------
-- Monk Job Utilities
-----------------------------------
require('scripts/globals/items')
require("scripts/globals/settings")
require("scripts/globals/status")
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
    ability:setRecast(ability:getRecast() - player:getMod(xi.mod.ONE_HOUR_RECAST))
    return 0, 0
end

xi.job_utils.monk.checkInnerStrength = function(player, target, ability)
    ability:setRecast(ability:getRecast() - player:getMod(xi.mod.ONE_HOUR_RECAST))
    return 0, 0
end

-----------------------------------
-- Ability Use Functions
-----------------------------------
xi.job_utils.monk.useBoost = function(player, target, ability)
    local power = 12.5 + (0.10 * player:getMod(xi.mod.BOOST_EFFECT))

    if player:hasStatusEffect(xi.effect.BOOST) then
        local effect = player:getStatusEffect(xi.effect.BOOST)
        effect:setPower(effect:getPower() + power)
        player:addMod(xi.mod.ATTP, power)
    else
        player:addStatusEffect(xi.effect.BOOST, power, 0, 180)
    end
end

xi.job_utils.monk.useChakra = function(player, target, ability)
    local chakraRemoval = player:getMod(xi.mod.CHAKRA_REMOVAL)

    for k, v in pairs(chakraStatusEffects) do
        if bit.band(chakraRemoval, v) == v then
            player:delStatusEffect(xi.effect[k])
        end
    end

    local jpModifier        = target:getJobPointLevel(xi.jp.CHAKRA_EFFECT) -- NOTE: Level is the modified value, so 10 per point spent
    local maxRecoveryAmount = (player:getStat(xi.mod.VIT) * (2 + player:getMod(xi.mod.CHAKRA_MULT) / 10)) + jpModifier
    local recoveryAmount    = math.min(player:getMaxHP() - player:getHP(), maxRecoveryAmount) -- TODO: Figure out "function of level" addition (August 2017 update)

    player:setHP(player:getHP() + recoveryAmount)

    local merits = player:getMerit(xi.merit.INVIGORATE)
    if merits > 0 then
        if player:hasStatusEffect(xi.effect.REGEN) then
            player:delStatusEffect(xi.effect.REGEN)
        end

        player:addStatusEffect(xi.effect.REGEN, 10, 0, merits, 0, 0, 1)
    end

    return recoveryAmount
end

xi.job_utils.monk.useChiBlast = function(player, target, ability)
    local boost = player:getStatusEffect(xi.effect.BOOST)
    local multiplier = 1.0
    if boost ~= nil then
        multiplier = (boost:getPower() / 100) * 4 -- power is the raw % atk boost
    end

    local dmg = math.floor(player:getStat(xi.mod.MND) * (0.5 + (math.random() / 2))) * multiplier

    dmg = utils.stoneskin(target, dmg)
    target:takeDamage(dmg, player, xi.attackType.SPECIAL, xi.damageType.ELEMENTAL)
    target:updateEnmityFromDamage(player, dmg)
    target:updateClaim(player)
    player:delStatusEffect(xi.effect.BOOST)

    return dmg
end

xi.job_utils.monk.useCounterstance = function(player, target, ability)
    local power = 45 + player:getMod(xi.mod.COUNTERSTANCE_EFFECT)

    target:delStatusEffect(xi.effect.COUNTERSTANCE) --if not found this will do nothing
    target:addStatusEffect(xi.effect.COUNTERSTANCE, power, 0, 300)
end

xi.job_utils.monk.useDodge = function(player, target, ability)
    local power = 20 + player:getMod(xi.mod.DODGE_EFFECT)

    player:addStatusEffect(xi.effect.DODGE, power, 0, 120)
end

xi.job_utils.monk.useFocus = function(player, target, ability)
    local power = 20 + player:getMod(xi.mod.FOCUS_EFFECT)

    player:addStatusEffect(xi.effect.FOCUS, power, 0, 120)
end

xi.job_utils.monk.useFootwork = function(player, target, ability)
    local kickDmg = 20 + player:getWeaponDmg()
    local kickAttPercent = 25 + player:getMod(xi.mod.FOOTWORK_ATT_BONUS)

    player:addStatusEffect(xi.effect.FOOTWORK, kickDmg, 0, 60, 0, kickAttPercent)
end

xi.job_utils.monk.useFormlessStrikes = function(player, target, ability)
    player:addStatusEffect(xi.effect.FORMLESS_STRIKES, 1, 0, 180)
end

xi.job_utils.monk.useHundredFists = function(player, target, ability)
    player:addStatusEffect(xi.effect.HUNDRED_FISTS, 1, 0, 45)
end

xi.job_utils.monk.useImpetus = function(player, target, ability)
    player:addStatusEffect(xi.effect.IMPETUS, 2, 0, 180)
end

xi.job_utils.monk.useInnerStrength = function(player, target, ability)
    player:addStatusEffect(xi.effect.INNER_STRENGTH, 2, 0, 30)
end

xi.job_utils.monk.useMantra = function(player, target, ability)
    local merits = player:getMerit(xi.merit.MANTRA)

    player:delStatusEffect(xi.effect.MAX_HP_BOOST)
    target:addStatusEffect(xi.effect.MAX_HP_BOOST, merits, 0, 180)

    return xi.effect.MANTRA -- TODO: implement xi.effect.MANTRA
end

xi.job_utils.monk.usePerfectCounter = function(player, target, ability)
    player:addStatusEffect(xi.effect.PERFECT_COUNTER, 2, 0, 30)
end
