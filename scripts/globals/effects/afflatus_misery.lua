-----------------------------------
-- xi.effect.AFFLATUS_MISERY
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:setMod(xi.mod.AFFLATUS_MISERY, 0)

    if (target:hasStatusEffect(xi.effect.AUSPICE)) then
        local power = target:getStatusEffect(xi.effect.AUSPICE):getPower()
        target:addMod(xi.mod.ENSPELL, 18)
        target:addMod(xi.mod.ENSPELL_DMG, power)
    end
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:setMod(xi.mod.AFFLATUS_MISERY, 0)

    --Clean Up Afflatus Misery Bonuses
    local accuracyBonus = effect:getSubPower()
    --printf("AUSPICE: Removing Accuracy Bonus +%d!", accuracyBonus)
    target:delMod(xi.mod.ACC, accuracyBonus)

    if (target:hasStatusEffect(xi.effect.AUSPICE)) then
        target:setMod(xi.mod.ENSPELL, 0)
        target:setMod(xi.mod.ENSPELL_DMG, 0)
    end
end

return effect_object
