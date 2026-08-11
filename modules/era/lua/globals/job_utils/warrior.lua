-----------------------------------
-- Module: Warrior Job Adjustments
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_job_utils_warrior', xi.pre(xi.expansion.ABYSSEA))

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
