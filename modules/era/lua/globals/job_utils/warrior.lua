-----------------------------------
-- Module: Warrior Job Adjustments
-----------------------------------
require('modules/module_utils')
-----------------------------------
local moduleName = 'era_job_utils_warrior'

-- If Abyssea or later is enabled, no changes.
if xi.module.isContentEnabled('ABYSSEA') then
    return { name = moduleName }
end

local m = Module:new(moduleName)

-- Warrior's Charge: Remove Triple Attack bonus
m:addOverride('xi.effects.warriors_charge.onEffectGain', function(target, effect)
    effect:addMod(xi.mod.DOUBLE_ATTACK, 100)
end)

-- Warrior's Charge: Apply merit recast reduction
m:addOverride('xi.job_utils.warrior.useWarriorsCharge', function(player, target, ability, action)
    local recastReduction = player:getMerit(xi.merit.WARRIORS_CHARGE) - 150
    action:setRecast(action:getRecast() - recastReduction)

    player:addStatusEffect(xi.effect.WARRIORS_CHARGE, { power = 1, duration = 60, origin = player })

    return xi.effect.WARRIORS_CHARGE
end)

return m
