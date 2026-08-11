-----------------------------------
-- Module: Thief Job Adjustments
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_job_utils_thief', xi.pre(xi.expansion.ABYSSEA))

-- Assassin's Charge: Remove Quadruple Attack
-- TODO: find a patch note or source for this change
m:addOverride('xi.effects.assassins_charge.onEffectGain', function(target, effect)
    effect:addMod(xi.mod.TRIPLE_ATTACK, 100)
end)

-- Assassin's Charge: Reduce cooldown by merit count
-- TODO: find a patch note or source for this change
m:addOverride('xi.job_utils.thief.useAssassinsCharge', function(player, target, ability, action)
    local recastReduction = player:getMerit(xi.merit.ASSASSINS_CHARGE) - 150
    action:setRecast(action:getRecast() - recastReduction)

    player:addStatusEffect(xi.effect.ASSASSINS_CHARGE, { power = 1, duration = 60, origin = player })

    return xi.effect.ASSASSINS_CHARGE
end)

-- Feint: Remove Treasure Hunter rate and reduce cooldown by merit count
-- TODO: find a patch note or source for this change
m:addOverride('xi.job_utils.thief.useFeint', function(player, target, ability, action)
    local recastReduction = player:getMerit(xi.merit.FEINT) - 120
    action:setRecast(action:getRecast() - recastReduction)

    player:addStatusEffect(xi.effect.FEINT, { power = 150, duration = 60, origin = player })
end)
