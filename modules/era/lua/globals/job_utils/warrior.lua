-----------------------------------
-- Module: Warrior Job Adjustments
-----------------------------------
-- https://forum.square-enix.com/ffxi/threads/44592-Oct-7-2014-%28JST%29-Version-Update (Berserk and Defender changes)
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_job_utils_warrior', xi.pre(xi.expansion.ABYSSEA))

-- Remove Level Scaling from Berserk
m:addOverride('xi.job_utils.warrior.useBerserk', function(player, target, ability)
    local power    = 25 + player:getMod(xi.mod.BERSERK_POTENCY)
    local duration = 180 + player:getMod(xi.mod.BERSERK_DURATION)

    player:addStatusEffect(xi.effect.BERSERK, { power = power, duration = duration, origin = player })

    return xi.effect.BERSERK
end)

-- Remove Level Scaling from Defender
m:addOverride('xi.job_utils.warrior.useDefender', function(player, target, ability)
    local duration = 180 + player:getMod(xi.mod.DEFENDER_DURATION)

    player:addStatusEffect(xi.effect.DEFENDER, { power = 25, duration = duration, origin = player })

    return xi.effect.DEFENDER
end)

-- Warrior's Charge: Remove Triple Attack bonus
-- TODO: find a patch note or source for this change
m:addOverride('xi.effects.warriors_charge.onEffectGain', function(target, effect)
    effect:addMod(xi.mod.DOUBLE_ATTACK, 100)
end)

-- Warrior's Charge: Apply merit recast reduction
-- TODO: find a patch note or source for this change
m:addOverride('xi.job_utils.warrior.useWarriorsCharge', function(player, target, ability, action)
    local recastReduction = player:getMerit(xi.merit.WARRIORS_CHARGE) - 150
    action:setRecast(action:getRecast() - recastReduction)

    player:addStatusEffect(xi.effect.WARRIORS_CHARGE, { power = 1, duration = 60, origin = player })

    return xi.effect.WARRIORS_CHARGE
end)
